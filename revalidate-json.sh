mkdir /tmp/correcturls /tmp/failedurls &>/dev/null 
rm  /tmp/failedurls/* /tmp/failedurls.log  &>/dev/null 
counter=0;
cat ttnconfig/rssfeeds.json |jq -c .[]|shuf|while read ln;do 
counter=$((counter+1));
num=$(echo $counter | awk '{printf("%04d", $1)}')
#echo "$counter"
url=$(echo "$ln"|jq -r .url);
filename=$(echo -n "$url"|md5sum |cut -d" " -f1)
outlet=$(echo "$ln"|jq -r .outlet);

thingyfound=no
filename=$(echo -n "$url"|md5sum |cut -d" " -f1)
test -e  /tmp/correcturls/$filename && thingyfound=yes
[[ "$thingyfound" = "no" ]] && {
    sslurl=$(echo "$url"|sed 's/http/https/g')
    grep -e "$sslurl" -e "$url"  /tmp/correcturls/* 2>/dev/null|grep -q "$url" && thingyfound="yes"
}

[[ "$thingyfound" = "no" ]] &&  {
a=$url; new="";statusc=$(curl  -s --header "Accept: */*" -A Firefox  --max-time 23 --connect-timeout 5 -o /tmp/tstfeed -w "%{http_code}" "$a")  ; 
failedurl=no; errrors=""; 
echo $statusc|grep -q -e 301 -e 302  && { new=$(curl -Ls -o /dev/null -w "%{url_effective}" "$a"); 
                                          origstatus=$statusc ;
                                          statusc=$(curl -4 -s --header "Accept: */*" -A Firefox  --max-time 23 --connect-timeout 5 -o /tmp/tstfeed -w "%{http_code}" "$new") ; } ; 

echo $statusc|grep -q -e 200 || { errors="R";failedurl=yes ; } ; 
echo -n  ; } ; 

[[ -z "$new" ]] || {
    newname=$(echo -n "$new"|md5sum |cut -d" " -f1)
    test -e  /tmp/correcturls/$newname && thingyfound=yes
[[ "$thingyfound" = "no" ]] && {
    echo "NOTFOUND $filename $url" >&2
    sslurl=$(echo "$newname"|sed 's/http/https/g')
    grep -e "$sslurl" -e "$newname"  /tmp/correcturls/* 2>/dev/null|grep -q "$url" && thingyfound="yes"
}
}



[[ "$thingyfound" = "no" ]] &&  (

cat /tmp/tstfeed|grep  -q -e '<rss xmlns:media="http://search.yahoo.com/mrss/" xmlns:dcterms="http://purl.org/dc/terms/"' -e '<rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns="http://purl.org/rss/1.0/" xmlns:' -e 'xml version="1.0" encoding="UTF-8"' -e 'http://www.w3.org/2005/Atom' -e '<feed xmlns="http://www.w3.org/2005/Atom" xmlns:app' -e '<?xml version="1.0" encoding="UTF-8"?><rss' -e '<atom:link href='  -e 'rss version="2.0" xmlns'  -e '<rdf:RDF>' -e '<rss version="0.91">' -e "rss xmlns:content" -e '<rss version' -e "rss xmlns:dc" -e "rss xmlns:atom" -e '<feed>' -e 'feed xmlns' || { errors=$errors" S";failedurl=yes ; } ; 


[[ "$failedurl" = "yes" ]] || ( 
                                returnurl="";
                                [[ -z "$new" ]] || returnurl="$new"
                                [[ -z "$new" ]] && returnurl="$url"
                                filename=$(echo -n "$returnurl"|md5sum |cut -d" " -f1)
                                echo $(echo "$ln"|jq -c 'del(.url)'| jq '. + {"url": "'"$returnurl"'"}')"," |tee  /tmp/correcturls/$filename
                                echo "OK: $filename | $returnurl |$url|$new"
                                ) ;

[[ "$failedurl" = "yes" ]] && ( 
                              filename=$(echo -n "$url"|md5sum |cut -d" " -f1)
                              echo "$ln" >> /tmp/failedurls/$filename
                              echo "ERROR: $a |$new |$statusc|$origstatus | $errors | $outlet" | tee -a /tmp/failedurls.log >&2 ) 
) & sleep 0.2 ;
done
sleep 20

wait
(echo '['
cat /tmp/correcturls/*|sort -u|tr -d '\n'|sed 's/,$//'|sed 's/},{/}\,{/g'
echo ']' )|jq .> /tmp/rssfeeds.json.new