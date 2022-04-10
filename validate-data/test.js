import fs from "fs";

import test from "ava";

test("urls are unique in rssfeeds.json", (t) => {
  const rssfeeds = JSON.parse(fs.readFileSync("../ttnconfig/rssfeeds.json"));
  const urls = rssfeeds.map((x) => x.url);

  const set = new Set();
  const duplicates = new Set();

  urls.forEach((x) => {
    if (set.has(x)) {
      duplicates.add(x);
    }
    set.add(x);
  });

  t.true(
    duplicates.size === 0,
    "The following URLs are duplicated: " + Array.from(duplicates).join(" ")
  );
});

test("all urls start with https:// or http://", (t) => {
  const rssfeeds = JSON.parse(fs.readFileSync("../ttnconfig/rssfeeds.json"));
  const urls = rssfeeds.map((x) => x.url);
  t.true(
    urls.every((x) => x.startsWith("https://") || x.startsWith("http://"))
  );
});
