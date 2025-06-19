---
layout: default-plain
title: Press
description: CityCamp in the news.
topics:
  - About
---

<div class="container post-main">
  {% assign sorted_items = site.data.press.docs
    | where_exp: "item", "item.state != ''"
    | where: "state", page.addressRegion
    | sort: 'date'
    | reverse
  %}
  {% include press-cards.html %}
</div>