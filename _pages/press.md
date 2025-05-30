---
layout: default-plain
title: Press
description: CityCamp in the news.
topics:
  - About
---

<div class="container post-main">
  <div class="row">
    <div class="card-group">
      {% for item in site.data.press.docs %}
        <div class="col-12 col-sm-12 col-md-4 col-lg-4 col-xl-4 d-flex align-items-stretch">
          <div class="card">
            <div class="card-body">
              <h3 class="card-title">
                <a href="{{ item.url }}" class="stretched-link nav-link">{{ item.title }}</a>
              </h3>
            </div>
            <div class="card-footer text-muted small">
              {{ item.source }}
            </div>
          </div>
        </div>
      {% endfor %}
    </div>
  </div>
</div>
