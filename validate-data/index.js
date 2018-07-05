import fs from "fs";

import test from "ava";

test("urls are unique in rssfeeds.json", t => {
  const rssfeeds = JSON.parse(fs.readFileSync("../ttnconfig/rssfeeds.json"));
  const urls = rssfeeds.map(x => x.url);

  const set = new Set();
  const duplicates = [];

  urls.forEach(x => {
    if (set.has(x)) {
      duplicates.push(x);
    }
    set.add(x);
  });

  t.true(
    duplicates.size === 0,
    "The following URL is duplicated: " + duplicates.join(" ")
  );
});
