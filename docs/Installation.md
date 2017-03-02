#  INSTALLATION  #

##  Installation on Mastodon  ##

Include this folder in `/app/assets/frontends` (feel free to create this folder if it doesn't exist).
Then perform the following actions:

1.  In the file `/app/views/home/index.html.haml`:

    - Change the line `= javascript_include_tag 'application'` to instead read `= javascript_include_tag 'labcoat'`
    - Add the line `= stylesheet_link_tag 'labcoat', media: 'all'` to the `:header_tags` declaration.
    - Remove the line `= react_component 'Mastodon', default_props, class: 'app-holder', prerender: false`.
    - Optionally, add the line `#frontend` in the location that you want the frontend to render. If this is not specified then the frontend will render in the `<body>` element, which React doesn't recommend.

2.  Add the following line to `/config/initializers/assets.rb`:

    ```ruby
    Rails.application.config.assets.precompile += %w(labcoat.css labcoat.js)
    ```

3.  Add the conditional `if controller_name != 'home'` at the end of the line `= stylesheet_link_tag('application', media: 'all')` in `/app/views/layouts/application.html.haml`.
    This will disable the default Mastodon frontend styles, which would otherwise conflict with our own.

4.  Restart your server.

##  Installation Elsewhere  ##

The files you want are probably **not** `index.js` and `index.scss` (which are intended for Mastodon), but rather those included in th `/lib/` folder; namely, `labcoat.min.js` and `labcoat.css`.
You should also be sure to include `laboratory.min.js` from [__Laboratory__](https://github.com/marrus-sh/laboratory), as it is a prerequisite.
Any HTML document which loads these files is a viable Labcoat frontend, regardless of how it is served; however, you will want to ensure that your frontend is properly [configured.](Configuration.md)
