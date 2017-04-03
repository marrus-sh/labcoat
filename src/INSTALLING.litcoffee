#  INSTALLING  #

There are a couple of different ways you might want to install Labcoat.
Labcoat is entirely client-side, which means that it can be operated from even something so minimal as a GitHub Pages site.
However, it is possible to configure Labcoat as the default frontend for a Mastodon server as well.

##  Installation Methods  ##

###  "Unhosted" install:

In the case of an unhosted (aka, not on a Mastodon server) install, you will want to *ignore* the root `index.js` and `index.scss` files and base your installation around `index.html`, which should work out-of-the box.
You will note that there are a *number* of `<script>` includes; you will provide your users faster service if you can cut this number down (if you are serving the script from Rails, for example, routing the scripts through Sprockets would be a wise idea).
However, it is important that every script is included.

###  Hosted install:

If you are hosting Labcoat on a Mastodon server, then the files `index.js` and `index.scss` will help you deploy the script.
However, until Mastodon gets proper frontend support we will have to do some hacking to get it to recognize these files.

####  Dependencies.

Labcoat expects you to have the following things installed on your server (these should be standard on any Mastodon install):

- `history`
- `font-awesome`
- `react`
- `react-addons-pure-render-mixin`
- `react-dom`
- `react-intl`
- `react-router`

You should also have a file somewhere in `/app/assets/stylesheets/` named `variables.scss`; you can use this to customize Labcoat's appearance.
Labcoat is designed for use with the fonts `Lato` and `Inconsolata`, so you should serve these somewhere if you want to take full advantage of its typographic features.
However, Labcoat does not itself look for or include these fonts.

####  Installation procedure.

The recommended procedure for installing Labcoat on a Mastodon server is as follows:

1.  Include this folder in `/app/assets/frontends` (feel free to create this folder if it doesn't exist).
    You could feasibly include it somewhere else in the `assets` directory (for example, `/app/assets/javascripts`), but as this package contains both scripts and stylesheets the `frontends` folder is recommended.

2.  In the file `/app/views/home/index.html.haml`:
    - Change the line `= javascript_include_tag 'application'` to instead read `= javascript_include_tag 'labcoat'`
    - Add the line `= stylesheet_link_tag 'labcoat', media: 'all'` to the `:header_tags` declaration.
    - Remove the line `= react_component 'Mastodon', default_props, class: 'app-holder', prerender: false`.
    - Optionally, add the line `#frontend` in the location that you want the frontend to render. If this is not specified then the frontend will render in the `<body>` element, which React doesn't recommend.

3.  Add the following line to `/config/initializers/assets.rb`:
    ```ruby
    Rails.application.config.assets.precompile += %w(labcoat.css labcoat.js)
    ```
    This will ensure that Labcoat's assets are properly precompiled.

4.  Add the conditional `if controller_name != 'home'` at the end of the line `= stylesheet_link_tag('application', media: 'all')` in `/app/views/layouts/application.html.haml`.
    This will disable the default Mastodon frontend styles, which would otherwise conflict with our own.

5.  Restart your server.

##  Configuration  ##

There are two ways which you can configure Labcoat beyond the initial installation.
The first, recommended method is by including a JSON configuration object in a `<script id="labcoat-config" type="application/json">` element somewhere in the document.
The second method is by including a script which provides configuration details to `window.INITIAL_STATE`.
**Use of `window.INITIAL_STATE` is strongly discouraged for "unhosted" installs and is only supported to minimize the amount of configuration necessary for installations on a Mastodon server.**

The configuration options supported by Labcoat are as follows:

###  General configuration:

| Property | INITIAL_STATE equivalent | Description |
| -------- | ------------------------ | :---------- |
| `title` | `meta.title` | The title for the frontend. If you are hosting this on a Mastodon server, you might want to set this to the name of the server. Otherwise, it will default to "Labcoat" |
| `display` | *Not supported* | Display modes (see below). |
| `basename` | `meta.router_basename` | The base pathname for the frontend. For example, a Labcoat frontend hosted at `http://example.org/gateway` would use the basename `/gateway`. This defaults to `/web` for compatibility reasons. |
| `useBrowserHistory` | `meta.use_history` | Use a more modern browser history instead of a hash-based history. For compatibility reasons, this defaults to `true`, so be sure to set this to `false` if your server isn't properly configured to handle it. |
| `locale` | `meta.locale` | The locale for the frontend. |
| `root` | `meta.react_root` | The id of the root element to draw the frontend into. Will default to `frontend`, if available, or the `<body>` element, if not. |
| `defaultPrivacy` | `compose.default_privacy` | The initial privacy setting to use for posts. This will default to `"unlisted"` if it isn't set. |
| `locales` | *Not supported* | Custom localization information—see [Locales](./Locales/). |

###  Single-user mode:

If Labcoat is being hosted on a Mastodon server, then you might want to provide user and authorization information yourself rather than force the user to sign in through the Labcoat OAuth client.
This is called __single-user mode__ and can be specified by setting the `accessToken` configuration property.
If this property is missing, Labcoat will boot normally.

| Property | INITIAL_STATE equivalent | Description |
| -------- | ------------------------ | :---------- |
| `accessToken` | `meta.access_token` | Provides the access token for single-user mode. |
| `origin` | `meta.origin` | Provides the origin for Mastodon API requests when in single-user mode. Defaults to `/`, but this does nothing if `user` isn't set. |

###  Display modes:

You can modify the appearance of Labcoat through the `display` configuration property, which should be an array of one or more of the following values:

| Value | Description |
| ----- | :---------- |
| `simple` | Removes text labels from the user interface. |
| `no-transparency` | Removes transparency from the user interface. |
| `reduce-motion` | Reduces the amount of motion effects in the user interface. |

The implementation of these display modes is largely handled by the Labcoat stylesheets.
There is not presently a means of setting display modes through `window.INITIAL_STATE`.

##  Styling  ##

If you are installing Labcoat on a Mastodon server, then you can easily configure its appearance by setting a number of variables in the `variables.scss` file in `app/assets/stylesheets`.
The recognized variables are as follows:

###  Fonts:

Labcoat won't load any fonts for you, so you should set these to fonts loaded elsewhere by your server or else ones which users might reasonably be expected to have.

| Variable | Default Value | Description |
| -------- | ------------- | :---------- |
| `$labcoat-sans` | `"Lato", "Helvetica Neue", "Helvetica", sans-serif` | The sans-serif font used by the frontend |
| `$labcoat-mono` | `"Inconsolata", "Courier Prime", monospace` | The monospace font used by the frontend |

###  Simple colours:

In order to make customizing Labcoat easier, the colour scheme has been reduced to these fourteen colours.
The default values for these colours use the "Print + Pastels" theme located in [`palettes.scss`](../styling/palettes.scss).
For more precision when customizing, look to the advanced colours further on.

| Variable | Default Value | Description |
| -------- | ------------- | :---------- |
| `$labcoat-rearColor` | `$print_dim` | The background colour for the frontend |
| `$labcoat-rearAccentColor` | `$print_black` | The accented background colour |
| `$labcoat-rearMinorColor` | `$print_dark` | The background colour of minor frontend elements |
| `$labcoat-frontColor` | `$print_bright` | The foreground (text) colour for the frontend |
| `$labcoat-frontAccentColor` | `$print_white` | The accented foreground colour |
| `$labcoat-frontMinorColor` | `$print_light` | The colour of minor foreground elements |
| `$labcoat-invertedRearColor` | `$print_bright` | An alternate background colour for elements like modules and cards |
| `$labcoat-invertedRearAccentColor` | `$print_white` | The accented alternate background colour |
| `$labcoat-invertedRearMinorColor` | `$print_light` | The alternate background colour of minor frontend elements |
| `$labcoat-invertedFrontColor` | `$print_black` | The foreground (text) colour for cards and modules |
| `$labcoat-invertedFrontAccentColor` | `$print_dark` | The accented alternate foreground colour |
| `$labcoat-invertedFrontMinorColor` | `$print_dim` | The alternate colour of minor foreground elements |
| `$labcoat-invertedFrontVeryMinorColor` | `$print_medium` | The alternate colour of *very* minor foreground elements |
| `$labcoat-invertedMidColor` | `$print` | A midrange colour for use with cards and modules, for borders and the like |

###  Opacities:

These are the various opacity levels for certain Labcoat elements.

| Variable | Default Value | Description |
| -------- | ------------- | :---------- |
| `$labcoat-headerBackgroundOpacity` | `.95` | The opacity of the site header's background |
| `$labcoat-columnBackgroundOpacity` | `.95` | The opacity of the left and right columns' backgrounds |
| `$labcoat-notificationBackgroundOpacity` | `.4` | The opacity of the notifications column's background |
| `$labcoat-notificationForegroundOpacity` | `.85` | The opacity of the notifications column's foreground |
| `$labcoat-curtainOpacity` | `.35` | The opacity of the curtain which appears behind modules when they are visible |
| `$labcoat-toggleInactiveOpacity` | `.4` | The opacity of toggle labels which are inactive |
| `$labcoat-leadingCommAtOpacity` | `.65` | The opacity of the leading `@` character in usernames |

###  Backgrounds:

These should take the form of the CSS `background` property.

| Variable | Default Value | Description |
| -------- | ------------- | :---------- |
| `$labcoat-queryBackground` | `linear-gradient(to top, $labcoat-rearAccentColor 20%, $labcoat-rearColor 80%)` | The background used for the instance query page |
| `$labcoat-background` | `$labcoat-rearColor` | The background used by the main frontend |

###  Advanced Colours:

The colour scheme actually deployed by Labcoat allows for far more nuance than the 14 basic colours outlined above.
As a matter of fact, virtually every class of component can be styled independently.
Setting the variables below allows you to develop a much more involved and/or nuanced theme, or to correct problems which arise during basic colour reconfiguration.

| Variable | Default Value | Description |
| -------- | ------------- | :---------- |
| `$labcoat-backgroundColor` | `$labcoat-rearColor` | The main background colour for the frontend |
| `$labcoat-queryTextColor` | `$labcoat-frontColor` | The main background colour for the frontend |
| `$labcoat-queryTextMinor` | `$labcoat-frontMinorColor` | The main background colour for the frontend |
| `$labcoat-queryTextMajor` | `$labcoat-frontAccentColor` | The main background colour for the frontend |
| `$labcoat-queryMarkColor` | `$labcoat-rearAccentColor` | The main background colour for the frontend |
| `$labcoat-columnColor` | `$labcoat-rearAccentColor` | The main background colour for the frontend |
| `$labcoat-columnTextColor` | `$labcoat-frontColor` | The main background colour for the frontend |
| `$labcoat-columnAccentTextColor` | `$labcoat-frontAccentColor` | The main background colour for the frontend |
| `$labcoat-columnHeadingColor` | `$labcoat-invertedRearAccentColor` | The main background colour for the frontend |
| `$labcoat-columnHeadingTextColor` | `$labcoat-invertedFrontMinorColor` | The main background colour for the frontend |

##  Implementation  ##

This script loads and runs the Labcoat frontend.
Consequently, it is the last thing we load.

###  First steps:

We include informative text about the `Labcoat` package on `Labcoat.ℹ` and give the version number on `Labcoat.Nº` for intersted parties.
Labcoat follows semantic versioning, which translates into `Nº` as follows: `Major * 100 + Minor + Patch / 100`.
Labcoat thus assures that minor and patch numbers will never exceed `99` (indeed this would be quite excessive!).

    Object.defineProperty window, "Labcoat",
        value : Object.freeze
            "ℹ"  : "https://github.com/marrus-sh/labcoat"
            "Nº" : 2.2
        enumerable : yes

###  Handling locale data:

This adds locale data so that our router can handle it:

    ReactIntl.addLocaleData [ReactIntlLocaleData.en..., ReactIntlLocaleData.de..., ReactIntlLocaleData.es..., ReactIntlLocaleData.fr..., ReactIntlLocaleData.pt..., ReactIntlLocaleData.hu..., ReactIntlLocaleData.uk...]

###  Configuration:

We'll wait for our `window` to load before reading our configuration and starting Labcoat.

    window.addEventListener "load", ->

The `config` object will store our configuration properties.
This won't be transparent to the `window`.
If `labcoat-config` is the id of a `<script>` element, we can go ahead and pull our configuration from there.

        config = JSON.parse elt.text if (elt = document.getElementById "labcoat-config") and do elt.tagName.toUpperCase is "SCRIPT"
        config ?= {}

We can now pull configuration properties from `window.INITIAL_STATE`, if present—but we won't overwrite the configuration we already have.

        INITIAL_STATE = {meta: {}} unless INITIAL_STATE?.meta?
        config[prop] = {
            title: INITIAL_STATE.meta.title || "Labcoat"
            basename: if INITIAL_STATE.meta.router_basename? then INITIAL_STATE.meta.router_basename else "/web"
            useBrowserHistory: INITIAL_STATE.meta.use_history or not INITIAL_STATE.meta.use_history?
            locale: INITIAL_STATE.meta.locale
            root: INITIAL_STATE.meta.react_root
            defaultPrivacy: INITIAL_STATE.composer?.default_privacy || "unlisted"
            accessToken: INITIAL_STATE.meta.accessToken
            origin: INITIAL_STATE.meta.origin || "/"
        }[prop] for prop in ["title", "basename", "useBrowserHistory", "locale", "root", "defaultPrivacy", "accessToken", "origin"] when not config[prop]?

####  Setting display modes:

Display modes are stored using `data-*` attributes on the root element.
We can set these now.

        if config.display?
            if "simple" in config.display then document.documentElement.setAttribute "data-labcoat-simple" else document.documentElement.removeAttribute "data-labcoat-simple"
            if "no-transparency" in config.display then document.documentElement.setAttribute "data-labcoat-no-transparency" else document.documentElement.removeAttribute "data-labcoat-no-transparency"
            if "reduce-motion" in config.display then document.documentElement.setAttribute "data-labcoat-reduce-motion" else document.documentElement.removeAttribute "data-labcoat-reduce-motion"

###  Loading our localization information:

This copies the information in `config.locales` into our `Locale` object, overwriting any existing messages.

        for locale, data of config.locales
            Locales[locale] = {} unless Locales[locale] instanceof Object
            Locales[locale][message] = value for message, value of data

We also set the language of the root element to our currently-selected locale.

        document.documentElement.setAttribute "lang", config.locale


###  Loading our frontend:

        run = ->

####  Setting the title.

We go ahead and set the title of the current `document` to the title given by our configuration.

            document.title = config.title

####  Getting the react root.

We'll go ahead and overwrite `config.root` with the actual element it points to, instead of just the id.
In order to properly handle our fallbacks, this is something of an involved process:

1.  If a `root` property, the object whose id matches the string value of this property will be used, if available.

2.  If there exists an element with id `"frontend"`, this will be used.

3.  If no such element exists, but there is at least one element of class name `"app-body"`, the first such element will be used.
This is a fallback for Mastodon.

4.  Otherwise, `document.body` is used as the React root.

            config.root = switch
                when config.root and (elt = document.getElementById String config.root) then elt
                when (elt = document.getElementById "frontend") then elt
                when (elt = (document.getElementsByClassName "app-body").item 0) then elt
                else document.body

####  Rendering into the root.

There are two different root elements that Labcoat might render.
The first, if we aren't in single-user mode, is a simple form for getting the origin from which to send the signin request.
The second is the frontend itself.

If we're running in single-user mode, we need to give Laboratory our authorization information.
Basically, we just spoof a server response.

            if config.accessToken then do (
                new Laboratory.Authorization.Requested
                    accessToken: config.accessToken
                    origin: config.origin
                    scope: Authorization.Scope.READWRITEFOLLOW
            ).start

Otherwise, we can go ahead and load our instance query now.

            else ReactDOM.render (
                彁 Shared.InstanceQuery,
                    title: config.title
                    locale: config.locale
                    basename: config.basename
            ), config.root

Finally, we add an event listener for `LaboratoryAuthorizationReceived`.
We're not actually interested in the data for this event, but it signals that our authorization worked and that the current user has been found.
Our callback for this event will load our *actual* frontend into our react root.

            callback = ->
                ReactDOM.unmountComponentAtNode config.root
                ReactDOM.render (
                    彁 Shared.Frontend,
                        title: config.title
                        locale: config.locale
                        myID: Laboratory.auth.me
                        useBrowserHistory: config.useBrowserHistory
                        basename: config.basename
                        defaultPrivacy: config.defaultPrivacy
                ), config.root
                document.removeEventListener "LaboratoryAuthorizationReceived", callback

            document.addEventListener "LaboratoryAuthorizationReceived", callback
            document.removeEventListener "LaboratoryInitializationReady", run

###  Running asynchronously:

We need to wait for Laboratory before we can load our frontend.

        if Laboratory?.ready then do run else document.addEventListener "LaboratoryInitializationReady", run
