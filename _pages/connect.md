---
layout: default-plain
title: Connect
description: Connect with CityCamp.
topics:
  - About
---

<main id="main-content">
  {% include jumbotron.html %}
  <div class="container post-main">
    <div class="row">
      <div class="card-group">
        {% for item in site.data.connect.docs %}
          <div class="col-12 col-sm-12 col-md-4 col-lg-4 col-xl-4 d-flex align-items-stretch">
            <div class="card text-center pt-4 pb-3 mx-2 mb-3 shadow">
              <div class="card-body">
                <a href="{{ item.url }}" class="stretched-link nav-link">
                  <p>
                    <i class="{{ item.icon }} fa-3x text-shadow" aria-label="{{ item.title }}"></i>
                  </p>
                  <p class="card-title">{{ item.title }}</p>
                </a>
              </div>
            </div>
          </div>
        {% endfor %}
      </div>
    </div>
  </div>
</main>
