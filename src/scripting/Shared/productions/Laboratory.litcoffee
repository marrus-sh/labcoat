#  `Shared.Laboratory`  #

##  Usage  ##

>   ```jsx
>       <Laboratory
>           locale=React.PropTypes.string.isRequired
>           myID=React.PropTypes.number.isRequired
>           useBrowserHistory=React.PropTypes.bool
>           title=React.PropTypes.string
>           links=React.PropTypes.object
>           routerBase=React.PropTypes.string
>           maxChars=React.PropTypes.number
>           defaultPrivacy=React.PropTypes.string
>       />
>   ```
>   Creates a `Laboratory` component, which acts as a container for the entire frontend. The accepted properties are:
>   -   **`locale` [REQUIRED `string`] :**
>       The locale in which to render the application.
>   -   **`myID` [REQUIRED `number`] :**
>       The account id for the currently signed-in user.
>   -   **`useBrowserHistory` [OPTIONAL `boolean`] :**
>       Whether to use browser history or hashes for the React Router.
>   -   **`title` [OPTIONAL `string`] :**
>       The title of the application.
>       Defaults to `window.location.hostname`.
>   -   **`links` [OPTIONAL `object`] :**
>       An object whose enumerable own properties give links to other areas of the site.
>   -   **`routerBase` [OPTIONAL `string`] :**
>       The base URL to use with the React router. Defaults to '/web'.
>   -   **`maxChars` [OPTIONAL `string`] :**
>       The maximum number of characters to allow in a post. Defaults to 500.
>   -   **`defaultPrivacy` [OPTIONAL `string`] :**
>       The default privacy setting. Defaults to "unlisted".

##  Imports  ##

Not really an import, but here's some convenience stuff for `react-router`.

    {Router, Route, IndexRoute, IndexRedirect} = ReactRouter

##  The Component  ##

`Laboratory` is just a React component class.
Here we define the initial properties, as above.

    Shared.Laboratory = React.createClass

        mixins: [PureRenderMixin]

        propTypes:
            locale: React.PropTypes.string.isRequired
            myID: React.PropTypes.number.isRequired
            title: React.PropTypes.string
            links: React.PropTypes.object
            routerBase: React.PropTypes.string
            maxChars: React.PropTypes.number
            useBrowserHistory: React.PropTypes.bool

        getDefaultProps: ->
            title: window.location.hostname
            routerBase: "/web"
            maxChars: 500
            defaultPrivacy: "unlisted"
            useBrowserHistory: true

        getInitialState: ->
            thirdColumn: 彁 Columns.Empty
            showComposer: false

###  Third column processing:

The component displayed in the third column varies as the user navigates around the site.
The function `setThirdColumn` allows us to manage this ourselves.

        setThirdColumn: (component, props) -> @setState {thirdColumn: 彁 component, props}

        getThirdColumn: -> @state.thirdColumn

###  Loading:

`componentWillMount` tells React what to do once our engine is about to load.

        componentWillMount: ->

This starts tracking our browser history for our router:

            @history = (if @props.useBrowserHistory then ReactRouter.useRouterHistory(History.createHistory) else ReactRouter.useRouterHistory(History.createHashHistory))({basename: @props.routerBase})

####  Pre-caluclating routes.

The React router will issue a warning in the console if you try modifying its routes after the inital render.
This is a problem because every time our state changes, `render()` will re-create our arrow functions and React will interpret this as an attempted change.
By calculating our routes ahead of time, we avoid this problem.

            @routes = 彁 Route, {path: '/', component: (props) => 彁 UI.UI, {title: @props.title, maxChars: @props.maxChars, defaultPrivacy: @props.defaultPrivacy, thirdColumn: @getThirdColumn(), myID: @props.myID, showComposer: @state.showComposer}, props.children},

                #  Go:

                彁 IndexRoute, {onEnter: => @setThirdColumn Columns.Go, {footerLinks: @props.links, myID: @props.myID}}

                #  Start:

                彁 Route, {path: 'start', onEnter: => @setThirdColumn Modules.Start}

                #  Timelines:

                彁 Route, {path: 'global', onEnter: => @setThirdColumn Columns.Timeline, {name: 'global'}}
                彁 Route, {path: 'community', onEnter: => @setThirdColumn Columns.Timeline, {name: 'community'}}
                彁 Route, {path: 'hashtag/:id', onEnter: (nextState) => @setThirdColumn Columns.Timeline, {name: 'hashtag/' + nextState.params.id}}

                #  Statuses:

                彁 Route, {path: 'compose', onEnter: (=> @setState(showComposer: true)), onLeave: (=> @setState(showComposer: false))}
                彁 Route, {path: 'post/:id', component: Modules.Post}

                #  Accounts:

                彁 Route, {path: 'user/:id', component: (props) => 彁 Modules.Account, {id: Number(props.params.id), myID: @props.myID}}
                彁 Route, {path: 'user/:id/posts', onEnter: (nextState) => @setThirdColumn Columns.Timeline, {name: 'user/' + nextState.params.id}}

                #  Not found:

                彁 Route, {path: '*', onEnter: => @setThirdColumn Columns.NotFound}

            return

###  Unloading:

`componentWillUnmount` tells react what to do if our engine gets deleted.
All we really care about is closing our stream.

        componentWillUnmount: ->
            if @subscription?
                @subscription.close()
                @subscription = undefined
            return

###  Rendering:

OKAY OKAY TIME TO RENDER.
Let's go!

        render: ->

…And here's what we render:

            return 彁 ReactIntl.IntlProvider, {locale: @props.locale, messages: Locales.getL10n(@props.locale)},
                彁 Router, {history: @history},
                    @routes