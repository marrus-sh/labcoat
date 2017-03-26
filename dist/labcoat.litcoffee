#  README  #

Welcome to the Labcoat source code!
Labcoat is an open-source, client-side frontend for Mastodon written in Literate CoffeeScript for use with Laboratory and React.js.
Its source files are parseable as regular Markdown documents, and this file is in fact part of the Laboratory source!

##  How to Read Labcoat Source Code  ##

Each Labcoat source code file is broadly split up into two parts: the *documentation*, which describes what the file does and how to use it, and the *implementation*, which actually implements the described algorithms and processes.
The documentation is (with the exception of this readme and the installation guide) always the first section in a file and titled "Usage".
The implementation will fill remaining sections, and generally should be safe to ignore—any important information should have already been covered in the description of what goes on in the file.
However, you can turn to the implementation if you are curious on how specific Labcoat features are actually coded.
(And, of course, if you are a computer, the compiled implementation is the only part of this file you will ever see!)

###  What to read:

If you're looking to use Labcoat in your project, then you should definitely familiarize yourself with the [installation guide](INSTALLING.litcoffee), which will provide details on Labcoat configuration and usage.
You might want to take a cursory glance at the files in the other folders if you are interested in providing Labcoat with your own styling.

##  Contributing  ##

Want to contribute to Labcoat?
That's great!
Feel free to submit a Pull Request through Github.
However, here are some guidelines to help your work be successful:

###  Document your code:

Labcoat is written in Literate CoffeeScript, so be literate about it!
Code should be written in a manner that flows well narratively, and written documentation explaining what it does in plain English should accompany any code.
It should be possible to understand *what* a file does by only reading the Markdown; the code exists to describe to a computer *how*.

###  Be mindful of data mutability:

If a property shouldn't be overwritten, you should define it with `Object.definePropery()`.
If an object should be considered immutable, use `Object.freeze()`.
You will find that most of the time when defining objects in our code one or both of these functions will come into play.

###  Be concise and elegant:

CoffeeScript is a very powerful language for writing code that is elegant and easy-to-read.
Take advantage of this!
Having text explanations above and below doesn't excuse messy code.

##  Implementation  ##

This file doesn't actually do much, but it's the first thing that our Labcoat script runs.

###  Introduction:

This is the first file in our compiled source, so let's identify ourselves real fast.

    ###

        ............... LABCOAT ................

         A client-side frontend for Mastodon, a
        free & open-source social network server
                   - - by Kibigo! - -

            Licensed under the MIT License.
               Source code available at:
          https://github.com/marrus-sh/labcoat

                    Version 0.2.0

    ###

Labcoat uses an [MIT License](../LICENSE.md) because it's designed to be easily customizable and extensible.
Feel free to make it your own!

###  Initial setup:

We'll use `彁` in place of `React.createElement` for brevity.
*彁* is what is known as a ["ghost character"](https://en.wikipedia.org/wiki/JIS_X_0208#Kanji_from_unknown_sources)—which is to say that it doesn't have any intrinsic meaning.
We use it because it's short and easy to spot.

    Object.defineProperty window, "彁", {value: React.createElement}

If Labcoat was installed directly onto a server, then its location will be `window.ReactPureRenderMixin`, but if it is loaded through the react-addons script, its location will be `React.addons.PureRenderMixin`.
We can't be bothered to test both every time we need to use it, so we'll store it locally at `ReactPureRenderMixin` if it hasn't already been defined on the window.

    ReactPureRenderMixin = React.addons.PureRenderMixin unless ReactPureRenderMixin?


#  Columns  #

##  Implementation  ##

    Columns = {}


#  `Columns.Column`  #

##  Usage  ##

>   ```jsx
>       <Column
>           id=React.PropTypes.string
>       >
>           {/* content */}
>       </Column>
>   ```
>   Creates a `Column` component, which contains a timeline or similar view.

##  The Component  ##

The `Column` is just a simple functional React component.

    Columns.Column = (props) ->
        彁 'div', (if props.id? then {id: props.id, className: "labcoat-column"} else {className: "labcoat-column"}),
            props.children


#  `Columns.GoLink`  #

##  Usage  ##

>   ```jsx
>       <GoLink
>           to=React.PropTypes.string.required
>           icon=React.PropTypes.string.required
>       />
>           {/* content */}
>       </GoLink>
>   ```
>   Creates a `Column` component which contains a menu of useful tasks. The accepted properties are:
>   -   **`to` [REQUIRED `string`] :**
>       Where the link is going to.
>   -   **`icon` [REQUIRED `string`] :**
>       The icon associated with the link.

##  The Component  ##

The `GoLink` component is a simple functional React component which just packages a `Link` with an icon.

    Columns.GoLink = (props) ->
        彁 ReactRouter.Link, {to: props.to, "aria-hidden": true},
            彁 Shared.Icon, {name: props.icon}
            props.children

    Columns.GoLink.propTypes =
        to: React.PropTypes.string.isRequired
        icon: React.PropTypes.string.isRequired


#  `Columns.Heading`  #

##  Usage  ##

>   ```jsx
>       <Heading
>           icon=React.PropTypes.string
>       >
>           {/* content */}
>       </Heading>
>   ```
>   Creates a `Heading` component, which is just the heading to a `Column`. The accepted properties are:
>   -   **`icon` [REQUIRED `string`] :**
>       The icon to associate with the heading.

##  The Component  ##

The `Heading` is just a simple functional React component.

    Columns.Heading = (props) ->
        彁 'h2', {className: "labcoat-heading"},
            if props.icon
                彁 Shared.Icon, {name: props.icon}
            else null
            props.children

    Columns.Heading.propTypes =
        icon: React.PropTypes.string


#  `Columns.Status`  #

##  Usage  ##

>   ```jsx
>       <Status
>           type=React.PropTypes.object.isRequired
>           id=React.PropTypes.number.isRequired
>           href=React.PropTypes.string
>           author=React.PropTypes.object.isRequired
>           inReplyTo=React.PropTypes.number
>           content=React.PropTypes.string
>           datetime=React.PropTypes.object
>           isReblogged=React.PropTypes.bool
>           isFavourited=React.PropTypes.bool
>           isNSFW=React.PropTypes.bool
>           message=React.PropTypes.string
>           visibility=React.PropTypes.object
>           mediaAttachments=React.PropTypes.array
>           mentions=React.PropTypes.array
>       />
>   ```
>   Creates a `Status` component, which contains a post or a notification. The accepted properties are:
>   -   **`type` [REQUIRED `object`] :**
>       The status's `Laboratory.PostType`.
>   -   **`id` [REQUIRED `number`] :**
>       The id of the status.
>   -   **`href` [OPTIONAL `string`] :**
>       A URL at which the status may be viewed.
>   -   **`author` [REQUIRED `object`] :**
>       The account which posted the status.
>   -   **`inReplyTo` [OPTIONAL `number`] :**
>       The id of the status this status is replying to.
>   -   **`content` [OPTIONAL `string`] :**
>       The content of the status.
>   -   **`datetime` [OPTIONAL `object`] :**
>       The time the status was created.
>   -   **`isReblogged` [OPTIONAL `boolean`] :**
>       Whether or not the user has reblogged this status.
>   -   **`isFavourited` [OPTIONAL `boolean`] :**
>       Whether or not the user has favourited this status.
>   -   **`isNSFW` [OPTIONAL `boolean`] :**
>       Whether or not this status contains sensitive media.
>   -   **`message` [OPTIONAL `string`] :**
>       Spoiler text to display over the status.
>   -   **`visibility` [OPTIONAL `object`] :**
>       The visibility of the status.
>   -   **`mediaAttachments` [OPTIONAL `array`] :**
>       An array of media attachments.
>   -   **`mentions` [OPTIONAL `array`] :**
>       An array of mentions.
>   -   **`rebloggedBy` [OPTIONAL `object`] :**
>       The account which reblogged this status.
>   -   **`favouritedBy` [OPTIONAL `object`] :**
>       The account which favourited this status.

##  The Component  ##

The `Status` component is a fairly involved React component, which loads an `<article>` containing the status and allowing the user to interact with it.

    Columns.Status = React.createClass

        mixins: [ReactPureRenderMixin]

        propTypes:
            type: React.PropTypes.object.isRequired
            id: React.PropTypes.number.isRequired
            href: React.PropTypes.string
            author: React.PropTypes.object.isRequired
            inReplyTo: React.PropTypes.number
            content: React.PropTypes.string
            datetime: React.PropTypes.object
            isReblogged: React.PropTypes.bool
            isFavourited: React.PropTypes.bool
            isNSFW: React.PropTypes.bool
            message: React.PropTypes.string
            visibility: React.PropTypes.object
            mediaAttachments: React.PropTypes.array
            mentions: React.PropTypes.array
            rebloggedBy: React.PropTypes.object
            favouritedBy: React.PropTypes.object
            follower: React.PropTypes.object

###  Pulling from the context:

We grab the router from the React context in order to handle page navigation.

        contextTypes:
            router: React.PropTypes.object.isRequired

###  Listing the mentions:

Our function `getListOfMentions()` gets the list of people mentioned in the post, although this is only shown if the post is a reply.
We follow the Chicago convention of using "et al." if there are more than three accounts.

        getListOfMentions: -> switch @props.mentions.length
            when 0 then []
            when 1 then [
                彁 ReactRouter.Link, {to: "/user/" + @props.mentions[0].id},
                    彁 "code", {className: "labcoat-username"}, @props.mentions[0].username
            ]
            when 2 then [
                彁 ReactRouter.Link, {to: "/user/" + @props.mentions[0].id},
                    彁 "code", {className: "labcoat-username"}, @props.mentions[0].username
                彁 ReactIntl.FormattedMessage,
                    id: "character.space"
                    message: " "
                彁 ReactIntl.FormattedMessage,
                    id: "status.and"
                    message: "and"
                彁 ReactIntl.FormattedMessage,
                    id: "character.space"
                    message: " "
                彁 ReactRouter.Link, {to: "/user/" + @props.mentions[1].id},
                    彁 "code", {className: "labcoat-username"}, @props.mentions[1].username
            ]
            when 3 then [
                彁 ReactRouter.Link, {to: "/user/" + @props.mentions[0].id},
                    彁 "code", {className: "labcoat-username"}, @props.mentions[0].username
                彁 ReactIntl.FormattedMessage,
                    id: "character.comma"
                    message: ", "
                彁 ReactRouter.Link, {to: "/user/" + @props.mentions[1].id},
                    彁 "code", {className: "labcoat-username"}, @props.mentions[1].username
                彁 ReactIntl.FormattedMessage,
                    id: "character.comma"
                    message: ", "
                彁 ReactIntl.FormattedMessage,
                    id: "status.and"
                    message: "and"
                彁 ReactIntl.FormattedMessage,
                    id: "character.space"
                    message: " "
                彁 ReactRouter.Link, {to: "/user/" + @props.mentions[2].id},
                    彁 "code", {className: "labcoat-username"}, @props.mentions[2].username
            ]
            else [
                彁 ReactRouter.Link, {to: "/user/" + @props.mentions[0].id},
                    彁 "code", {className: "labcoat-username"}, @props.mentions[0].username
                彁 ReactIntl.FormattedMessage,
                    id: "character.space"
                    message: " "
                彁 ReactIntl.FormattedMessage,
                    id: "status.etal"
                    message: "et al."
            ]

        render: ->
            if @props.follower
                彁 "article", {className: "labcoat-status"},
                    彁 Shared.IDCard,
                        account: @props.follower
                    彁 ReactIntl.FormattedMessage,
                        id: "character.space"
                        message: " "
                    彁 ReactIntl.FormattedMessage,
                        id: "status.followedyou"
                        message: "followed you!"
            else
                彁 "article", {className: "labcoat-status" + (if @props.isFavourited then " labcoat-status--favourited" else "")},
                    if @props.rebloggedBy? or @props.favouritedBy? or @props.inReplyTo? then 彁 "aside", null, (
                        switch
                            when @props.inReplyTo? and @props.rebloggedBy? then [
                                彁 ReactRouter.Link, {to: "/user/" + @props.rebloggedBy.id},
                                    彁 "code", {className: "labcoat-username"}, @props.rebloggedBy.username
                                彁 ReactIntl.FormattedMessage,
                                    id: "character.space"
                                    message: " "
                                (
                                    if @props.mentions?.length then [
                                        彁 ReactIntl.FormattedMessage,
                                            id: "status.rebloggedthisreplyto"
                                            message: "boosted this reply to"
                                        彁 ReactIntl.FormattedMessage,
                                            id: "character.space"
                                            message: " "
                                        do @getListOfMentions...
                                    ]
                                    else [
                                        彁 ReactIntl.FormattedMessage,
                                            id: "status.rebloggedthisreply"
                                            message: "boosted this reply"
                                    ]
                                )...
                            ]
                            when @props.inReplyTo? and @props.favouritedBy? then [
                                彁 ReactRouter.Link, {to: "/user/" + @props.favouritedBy.id},
                                    彁 "code", {className: "labcoat-username"}, @props.favouritedBy.username
                                彁 ReactIntl.FormattedMessage,
                                    id: "character.space"
                                    message: " "
                                (
                                    if @props.mentions?.length then [
                                        彁 ReactIntl.FormattedMessage,
                                            id: "status.favouritedthisreplyto"
                                            message: "highlighted this reply to"
                                        彁 ReactIntl.FormattedMessage,
                                            id: "character.space"
                                            message: " "
                                        do @getListOfMentions...
                                    ]
                                    else [
                                        彁 ReactIntl.FormattedMessage,
                                            id: "status.favouritedthisreply"
                                            message: "highlighted this reply"
                                    ]
                                )...
                            ]
                            when @props.rebloggedBy? then [
                                彁 ReactRouter.Link, {to: "/user/" + @props.rebloggedBy.id},
                                    彁 "code", {className: "labcoat-username"}, @props.rebloggedBy.username
                                彁 ReactIntl.FormattedMessage,
                                    id: "character.space"
                                    message: " "
                                彁 ReactIntl.FormattedMessage,
                                    id: "status.rebloggedthisstatus"
                                    message: "boosted this post"
                            ]
                            when @props.favouritedBy? then [
                                彁 ReactRouter.Link, {to: "/user/" + @props.favouritedBy.id},
                                    彁 "code", {className: "labcoat-username"}, @props.favouritedBy.username
                                彁 ReactIntl.FormattedMessage,
                                    id: "character.space"
                                    message: " "
                                彁 ReactIntl.FormattedMessage,
                                    id: "status.favouritedthisstatus"
                                    message: "highlighted this post"
                            ]
                            when @props.inReplyTo?
                                if @props.mentions?.length then [
                                    彁 ReactIntl.FormattedMessage,
                                        id: "status.inreplyto"
                                        message: "In reply to"
                                    彁 ReactIntl.FormattedMessage,
                                        id: "character.space"
                                        message: " "
                                    do @getListOfMentions...
                                ]
                                else [
                                    彁 ReactIntl.FormattedMessage,
                                        id: "status.inreplytoself"
                                        message: "In reply to themselves"
                                ]
                        )...
                    else null
                    彁 "header", null,
                        彁 Shared.IDCard,
                            account: @props.author
                        彁 ReactIntl.FormattedRelative, {value: Date.parse @props.datetime},
                            (formattedDate) => 彁 "time", {dateTime: @props.datetime, title: @props.datetime}, formattedDate
                    彁 "div",
                        className: "labcoat-statusContent"
                        dangerouslySetInnerHTML:
                            __html: @props.content
                    if @props.type is Laboratory.Post.Type.STATUS or @props.author.relationship isnt Laboratory.Profile.Relationship.SELF
                        彁 "footer", null,
                            彁 Shared.Action,
                                className: "labcoat-reply"
                                icon: "icon.reply"
                                label: 彁 ReactIntl.FormattedMessage,
                                    id: "status.reply"
                                    defaultMessage: "Reply"
                                action: =>
                                    @context.router.push "/compose?text=" + (if @props.author.relationship isnt Laboratory.Profile.Relationship.SELF then "@" + @props.author.localAccount else "") + "&inReplyTo=" + @props.id
                            if @props.isFavourited
                                彁 Shared.Action,
                                    active: yes
                                    className: "labcoat-unfavourite"
                                    icon: "icon.unfavourite"
                                    label: 彁 ReactIntl.FormattedMessage,
                                        id: "status.unfavourite"
                                        defaultMessage: "Unhighlight"
                                    action: => Laboratory.dispatch "LaboratoryPostSetFavourite",
                                        id: @props.id
                                        value: off
                            else
                                彁 Shared.Action,
                                    active: no
                                    className: "labcoat-favourite"
                                    icon: "icon.favourite"
                                    label: 彁 ReactIntl.FormattedMessage,
                                        id: "status.favourite"
                                        defaultMessage: "Highlight"
                                    action: => Laboratory.dispatch "LaboratoryPostSetFavourite",
                                        id: @props.id
                                        value: on
                            if @props.isReblogged
                                彁 Shared.Action,
                                    active: yes
                                    className: "labcoat-unreblog"
                                    icon: "icon.unreblog"
                                    label: 彁 ReactIntl.FormattedMessage,
                                        id: "status.unreblog"
                                        defaultMessage: "Unboost"
                                    action: => Laboratory.dispatch "LaboratoryPostSetReblog",
                                        id: @props.id
                                        value: off
                            else if @props.visibility & Laboratory.Post.Visibility.REBLOGGABLE
                                彁 Shared.Action,
                                    active: no
                                    className: "labcoat-reblog"
                                    icon: "icon.reblog"
                                    label: 彁 ReactIntl.FormattedMessage,
                                        id: "status.reblog"
                                        defaultMessage: "Boost"
                                    action: => Laboratory.dispatch "LaboratoryPostSetReblog",
                                        id: @props.id
                                        value: on
                            else
                                彁 Shared.Action,
                                    active: no
                                    className: "labcoat-noreblog"
                                    icon: "icon.noreblog"
                                    disabled: yes
                                    label: 彁 ReactIntl.FormattedMessage,
                                        id: "status.noreblog"
                                        defaultMessage: "Private"
                    else null


#  `Columns.Empty`  #

##  Usage  ##

>   ```jsx
>       <Empty />
>   ```
>   Creates an empty `Column`.

##  The Component  ##

The `Empty` component is just a simple functional React component, which loads an empty `Column`.

    Columns.Empty = -> 彁 Columns.Column, {id: "labcoat-empty"}, 彁 Columns.Heading


#  `Columns.Go`  #

##  Usage  ##

>   ```jsx
>       <Go
>           myID=React.PropTypes.number.isRequired
>           footerLinks=React.PropTypes.object
>       />
>   ```
>   Creates a `Column` component which contains a menu of useful tasks. The accepted properties are:
>   -   **`myID` [OPTIONAL `number`] :**
>       The id of the currently signed-in user.
>   -   **`footerLinks` [OPTIONAL `object`] :**
>       An object whose enumerable own properties provide links to display in the footer.

##  The Component  ##

The `Go` component is just a simple functional React component, which loads a `Column` with helpful links.

    Columns.Go = (props) ->
        彁 Columns.Column, {id: "labcoat-go"},
            彁 Columns.Heading, {icon: "icon.go"},
                彁 ReactIntl.FormattedMessage,
                    id: "go.heading"
                    defaultMessage: "let's GO!"
            彁 "nav", {className: "labcoat-columnnav"},
                彁 Columns.GoLink, {to: "/user/" + props.myID, icon: "icon.profile"},
                    彁 ReactIntl.FormattedMessage,
                        id: 'go.profile'
                        defaultMessage: "Profile"
                彁 Columns.GoLink, {to: "/community", icon: "icon.community"},
                    彁 ReactIntl.FormattedMessage,
                        id: 'go.community'
                        defaultMessage: "Community"
                彁 Columns.GoLink, {to: "/global", icon: "icon.global"},
                    彁 ReactIntl.FormattedMessage,
                        id: 'go.global'
                        defaultMessage: "Global"
            彁 "footer", {className: "labcoat-columnfooter"},
                彁 "nav", null,
                    (彁 "a", {href: value, target: "_self"}, key for key, value of (if props.footerLinks? then props.footerLinks else {}))...

    Columns.Go.propTypes =
        footerLinks: React.PropTypes.object
        myID: React.PropTypes.number.isRequired


#  `Columns.NotFound`  #

##  Usage  ##

>   ```jsx
>       <NotFound />
>   ```
>   Creates a `Column` component, which remarks that the content could not be found.

##  The Component  ##

The `NotFound` component is just a simple functional React component, which loads a `Column` and remarks that the page could not be found.

    Columns.NotFound = ->
        彁 Columns.Column, {id: "labcoat-notfound"},
            彁 Columns.Heading, {icon: "icon.notfound"},
                彁 ReactIntl.FormattedMessage,
                    id: 'notfound.notfound'
                    defaultMessage: "Not found"
            彁 ReactIntl.FormattedMessage,
                id: 'notfound.notfound'
                defaultMessage: "Not found"


#  `Columns.Timeline`  #

##  Usage  ##

>   ```jsx
>       <Timeline
>           name=React.PropTypes.string.isRequired
>       />
>   ```
>   Creates a `Timeline` component, which contains a timeline of statuses. The accepted properties are:
>   -   **`name` [REQUIRED `string`] :**
>       The name of the timeline.

##  The Component  ##

Our Timeline only has one property, a string specifying the `name` of the timeline.

    Columns.Timeline = React.createClass

        mixins: [ReactPureRenderMixin]

        propTypes:
            name: React.PropTypes.string.isRequired

        getInitialState: ->
            timeline: null

###  Handling the event callback:

When we receive a response from Laboratory, we have to handle it with respect to our state.

        handleResponse: (event) ->
            params = do @getParams
            timeline = event.detail
            @setState {timeline} if timeline.type is params.type and timeline.query is params.query

###  Getting the timeline parameters:

The timeline parameters can be derived from `name` using the following function:

        getParams: (name = @props.name) -> switch
            when name is "home"
                type: Laboratory.Timeline.Type.HOME
                query: ""
            when name is "community"
                type: Laboratory.Timeline.Type.LOCAL
                query: ""
            when name is "global"
                type: Laboratory.Timeline.Type.GLOBAL
                query: ""
            when (name.substr 0, 8) is "hashtag/"
                type: Laboratory.Timeline.Type.HASHTAG
                query: name.substr 8
            when (name.substr 0, 5) is "user/"
                type: Laboratory.Timeline.Type.USER
                query: name.substr 5
            when name is "notifications"
                type: Laboratory.Timeline.Type.NOTIFICATIONS
                query: ""
            when name is "highlights"
                type: Laboratory.Timeline.Type.FAVOURITES
                query: ""
            else
                type: Laboratory.Timeline.Type.UNDEFINED
                query: ""

###  Getting the heading icon:

The heading icon can be derived from `name` using the following function:

        getIcon: -> switch (do @getParams).type
            when Laboratory.Timeline.Type.HOME then "icon.home"
            when Laboratory.Timeline.Type.LOCAL then "icon.community"
            when Laboratory.Timeline.Type.GLOBAL then "icon.global"
            when Laboratory.Timeline.Type.HASHTAG is "hashtag/" then "icon.hashtag"
            when Laboratory.Timeline.Type.USER is "user/" then "icon.user"
            when Laboratory.Timeline.Type.NOTIFICATIONS then "icon.notifications"
            when Laboratory.Timeline.Type.FAVOURITES then "icon.favourite"
            else "icon.mystery"

###  Property change:

If our `name` property changes then we need to request the new data.

        componentWillReceiveProps: (nextProps) ->
            return unless @props.name isnt nextProps.name
            Laboratory.dispatch "LaboratoryTimelineRequested", @getParams nextProps.name

###  Loading:

When our timeline first loads, we should request its data.

        componentWillMount: ->
            Laboratory.listen "LaboratoryTimelineReceived", @handleResponse
            Laboratory.dispatch "LaboratoryTimelineRequested", do @getParams

###  Unloading:

When our timeline unloads, we should forget our listener.

        componentWillUnmount: ->
            Laboratory.forget "LaboratoryTimelineReceived", @handleResponse

###  Rendering:

        render: ->
            彁 Columns.Column, (if @props.name is "notifications" then {id: "labcoat-notifications"} else null),
                彁 Columns.Heading, {icon: do @getIcon},
                    彁 ReactIntl.FormattedMessage,
                        id: "timeline." + @props.name
                        defaultMessage: do (@props.name.charAt 0).toLocaleUpperCase + @props.name.slice 1
                if @state.timeline? then 彁 "div", {className: "labcoat-posts"},
                    (彁 Columns.Status, post for post in @state.timeline.posts)...
                else null


#  MODULES  #

##  Implementation  ##

    Modules = {}


#  `Modules.Module`  #

##  Usage  ##

>   ```jsx
>       <Module
>           attributes=React.PropTypes.object
>           close=React.PropTypes.bool
>           closeTo=React.PropTypes.object
>       >
>           {/*  contents  */}
>       </Module>
>   ```
>   Creates a module overlay, rendering its contents inside. The accepted properties are:
>   -   **`attributes` [Optional `object`] :**
>       Attributes to set on the `<main>` object.
>   -   **`close` [OPTIONAL `boolean`] :**
>       Whether or not the module should be closed.
>   -   **`closeTo` [OPTIONAL `string`] :**
>       The URL to redirect the user to upon closing.

##  The Component  ##

The `Module` component is just a fairly simple React component, which loads a module as the `<main>` element on the page with a curtain behind.

    Modules.Module = React.createClass

        mixins: [ReactPureRenderMixin]

        propTypes:
            attributes: React.PropTypes.object
            close: React.PropTypes.bool
            closeTo: React.PropTypes.string

        getInitialState: ->
            shouldClose: @props.close

###  Pulling from the context:

We grab the router from the React context in order to handle page navigation.

        contextTypes:
            router: React.PropTypes.object.isRequired

###  Updating with new props:

When our component receives new props, we run our `close()` function if the `close` property is set.

        componentWillReceiveProps: (nextProps) ->
            return unless nextProps.close and not @state.shouldClose
            do @close

###  Closing:

The `close()` function sets our `shouldClose` state property and then does a redirect away from the current page.
If there is somewhere to `closeTo`, then it redirects the user there; if not, it attemps to navigate back and if that fails instead redirects home.
We do this on a `.5s` timeout to give our closing animation time to run.

        close: ->
            @setState {shouldClose: true}
            window.setTimeout (=> if @props.closeTo or window.history?.length <= 1 then @context.router.push @props.closeTo or "/" else do @context.router.goBack), 500

###  Rendering:

The `render()` function displays our module: just a `<div>` curtain behind our `<main>` element, with children stuck inside.

        render: ->
            彁 "div", (if @state.shouldClose then {id: "labcoat-module", "data-labcoat-dismiss": ""} else {id: "labcoat-module"}),
                彁 "div", {id: "labcoat-curtain", onClick: @close}
                彁 "main", (if @props.attributes? then @props.attributes else null),
                @props.children


#  `Modules.Account`  #

##  Usage  ##

>   ```jsx
>       <Account
>           id=React.PropTypes.number.isRequired
>           myID=React.PropTypes.number.isRequired
>       />
>   ```
>   Creates a `Composer` component, which allows a user to compose a post. The accepted properties are:
>   -   **`id` [REQUIRED `number`] :**
>       The user id for the account to display.
>   -   **`myID` [REQUIRED `number`] :**
>       The user id for the currently logged-in user.

##  The Component  ##

Our Account only has one property, a number specifying the `id` of the timeline.

    Modules.Account = React.createClass

        mixins: [ReactPureRenderMixin]

        propTypes:
            id: React.PropTypes.number.isRequired
            myID: React.PropTypes.number.isRequired

        getInitialState: ->
            account: null

###  Handling the event callback:

When we receive a response from Laboratory, we have to handle it with respect to our state.

        handleResponse: (event) ->
            account = event.detail
            @setState {account} if account.id is @props.id

###  Property change:

If our `id` property changes then we need to request the new data.
Essentially we remove our old request and send a new one.

        componentWillReceiveProps: (nextProps) ->
            return unless @props.id isnt nextProps.id
            Laboratory.dispatch "LaboratoryProfileRequested", {id: nextProps.id}

###  Loading:

When our account first loads, we should request its data.

        componentWillMount: ->
            Laboratory.listen "LaboratoryProfileReceived", @handleResponse
            Laboratory.dispatch "LaboratoryProfileRequested", {id: @props.id}

###  Unloading:

When our account unloads, we should signal that we no longer need its data.

        componentWillUnmount: ->
            Laboratory.forget "LaboratoryProfileReceived", @handleResponse

###  Rendering:

Our account state is managed by our handlers.
We can check to see if they have succeeded in retreiving our data by comparing the `id` of our properties to the `account.id` of our state.
If these aren't the same, then our request hasn't yet gone through.
However, we will only prevent rendering if our state `account` is `null`—that is, if no request has gone through.
Otherwise, we will let the old data stay until our new information is loaded.

        render: ->
            return null unless @state.account?
            彁 Modules.Module, {attributes: {id: "labcoat-account"}},
                彁 "header", {style: {backgroundImage: "url(#{@state.account.header})"}},
                    彁 "a", {src: @state.account.header, target: "_blank"}
                彁 Shared.IDCard, {account: @state.account, externalLinks: true}
                switch
                    when @state.account.relationship & Laboratory.Profile.Relationship.SELF then null
                    when @state.account.relationship & Laboratory.Profile.Relationship.FOLLOWING
                        彁 Shared.Button,
                            label: 彁 ReactIntl.FormattedMessage,
                                id: "account.unfollow"
                                defaultMessage: "Unfollow"
                            icon: "icon.unfollow"
                    when @state.account.relationship & Laboratory.Profile.Relationship.BLOCKING
                        彁 Shared.Button,
                            label: 彁 ReactIntl.FormattedMessage,
                                id: "account.blocked"
                                defaultMessage: "Blocked"
                            icon: "icon.blocked"
                            disabled: true
                    when @state.account.relationship & Laboratory.Profile.Relationship.REQUESTED
                        彁 Shared.Button,
                            label: 彁 ReactIntl.FormattedMessage,
                                id: "account.requested"
                                defaultMessage: "Request Sent"
                            icon: "icon.requested"
                            disabled: true
                    else
                        if @state.account.locked
                            彁 Shared.Button,
                                label: 彁 ReactIntl.FormattedMessage,
                                    id: "account.request"
                                    defaultMessage: "Request Follow"
                                icon: "icon.request"
                        else
                            彁 Shared.Button,
                                label: 彁 ReactIntl.FormattedMessage,
                                    id: "account.follow"
                                    defaultMessage: "Follow"
                                icon: "icon.follow"
                彁 "p",
                    dangerouslySetInnerHTML:
                        __html: @state.account.bio
                彁 "footer", null,
                    彁 "table", null,
                        彁 "tbody", null,
                            彁 "tr", null,
                                彁 "td", null,
                                    彁 "b", null, @state.account.statusCount
                                    彁 ReactIntl.FormattedMessage,
                                        id: "account.statuses"
                                        defaultMessage: "Posts"
                                彁 "td", null,
                                    彁 "b", null, @state.account.followingCount
                                    彁 ReactIntl.FormattedMessage,
                                        id: "account.following"
                                        defaultMessage: "Follows"
                                彁 "td", null,
                                    彁 "b", null, @state.account.followerCount
                                    彁 ReactIntl.FormattedMessage,
                                        id: "account.followers"
                                        defaultMessage: "Followers"


#  `Modules.Composer`  #

##  Usage  ##

>   ```jsx
>       <Composer
>           maxChars=React.PropTypes.number.isRequired
>           myID=React.PropTypes.number.isRequired
>           visible=React.PropTypes.boolean
>           defaultPrivacy=React.PropTypes.string
>           text=React.PropTypes.string
>           inReplyTo=React.PropTypes.number
>       />
>   ```
>   Creates a `Composer` component, which allows a user to compose a post. The accepted properties are:
>   -   **`maxChars` [REQUIRED `number`] :**
>       The maximum number of characters allowed in a post. closed.
>   -   **`myID` [REQUIRED `number`] :**
>       The account object for the currently signed-in user.
>   -   **`visible` [OPTIONAL `boolean`] :**
>       Whether or not to show the composer
>   -   **`defaultPrivacy` [OPTIONAL `string`] :**
>       Should be one of {`"public"`, `"private"`, `"unlisted"`}, and effectively defaults to `"unlisted"` if not provided.
>   -   **`text` [OPTIONAL `string`] :**
>       The initial text for the composer.
>   -   **`inReplyTo` [OPTIONAL `number`] :**
>       The post ID which this post is replying to.

##  The Component  ##

The `Composer` class creates our post composition module, which is a surprisingly complex task.

    Modules.Composer = React.createClass

        mixins: [ReactPureRenderMixin]

        propTypes:
            maxChars: React.PropTypes.number.isRequired
            myID: React.PropTypes.number.isRequired
            defaultPrivacy: React.PropTypes.string
            visible: React.PropTypes.bool
            text: React.PropTypes.string
            inReplyTo: React.PropTypes.number

        getDefaultProps: ->
            text: ""
            inReplyTo: undefined

###  Our state:

Here you can see our initial state variables—we have quite a lot of them, as this component manages the extensive compose form.
You will note that `text` is initialized to `\n`—in order to function properly, a line break must always be the last thing it produces.

        getInitialState: ->
            account: null
            replyStatus: null
            text: @props.text + "\n"
            inReplyTo: if isFinite @props.inReplyTo then Number @props.inReplyTo else undefined
            message: ""
            charsLeft: @props.maxChars
            makePublic: @props.defaultPrivacy isnt "private"
            makeListed: @props.defaultPrivacy is "public"
            makeNSFW: false
            forceNSFW: true
            useMessage: false
            shouldClose: false

###  Pulling from the context:

We will also need `intl` from the React context in order to access the composer placeholder text.

        contextTypes:
            intl: React.PropTypes.object.isRequired

###  Handling the event callback:

When we receive a response from Laboratory, we have to handle it with respect to our state.

        handleResponse: (event) ->
            response = event.detail
            switch
                when response instanceof Laboratory.Profile then @setState {account: response}
                when response instanceof Laboratory.Post and response.id is @props.inReplyTo then @setState {replyStatus: response}
            return

###  Loading:

When our compose module first loads, we should request the account data for the currently signed-in user.
We'll also request the status the post is replying to, if applicable.

        componentWillMount: ->
            Laboratory.listen "LaboratoryProfileReceived", @handleResponse
            Laboratory.dispatch "LaboratoryProfileRequested", {id: @props.myID}
            if isFinite @props.inReplyTo
                Laboratory.listen "LaboratoryPostReceived", @handleResponse
                Laboratory.dispatch "LaboratoryPostRequested", {id: @props.inReplyTo}

###  Unloading:

When our compose module unloads, we should signal that we no longer need its data.

        componentWillUnmount: ->
            Laboratory.forget "LaboratoryProfileReceived", @handleResponse
            Laboratory.forget "LaboratoryPostReceived", @handleResponse

###  Our inputs:

We store our inputs in a instance variable, and you'll see in `render()` that we're using the `ref` attribute to get their values.

        input:
            textbox: null
            message: null
            makePublic: null
            makeListed: null
            makeNSFW: null
            useMessage: null
            post: null

###  Updating:

The `shouldClose` state variable is used to register the fact that a post has been sent, and the composer module should now close.
However, we don't want this variable to *keep* signalling this fact if we then open the composer a second time.
If our `visible` property switches from `false` to `true` then we reset `shouldClose` before proceeding.

        componentWillReceiveProps: (nextProps) ->

            @setState {shouldClose: false} if not @props.visible and nextProps.visible

If our props are about to change so we are replying to a different status, we need to request it.

            if (isFinite nextProps.inReplyTo) and nextProps.inReplyTo isnt @props.inReplyTo
                Laboratory.listen "LaboratoryPostReceived", @handleResponse
                Laboratory.dispatch "LaboratoryPostRequested", {id: nextProps.inReplyTo}

If our props update, we should update the store to reflect the new data.

            @setState {text: nextProps.text + "\n"} if nextProps.text isnt @props.text
            @setState {inReplyTo: Number nextProps.inReplyTo} if (isFinite nextProps.inReplyTo) and nextProps.inReplyTo isnt @props.inReplyTo

###  Finding out how many characters are left:

This code quickly replaces all surrogate pairs with a single underscore to achieve an accurate character count.

        getCharsLeft: -> @charsLeft = @props.maxChars - ((@input.textbox.value + @input.message.value).replace /[\uD800-\uDBFF][\uDC00-\uDFFF]/g, "_").length + 1

###  Formatting our text:

This code is used to generate the HTML content of our textbox.
We do this by creating text nodes inside a `<div>` in order to keep our text properly encapsulated and safe.
We then return the `innerHTML` of the result.

We use `<br>`s to represent line-breaks because these have the best browser support.
Again, in order for everything to function smoothly we need to ensure that the last node in this result is a `<br>` element.

        format: (text) ->
            result = document.createElement "div"
            lines = text.split "\n"
            for i in [0..lines.length-1]
                result.appendChild document.createTextNode lines[i] if lines[i]
                result.appendChild document.createElement "br" if i isnt lines.length - 1 or lines[i]
            return result.innerHTML

###  Event handling:

This handles the events from all of our inputs *except* our textbox, essentially just setting the corresponding state value.
We also do checks regarding public/private and listed/unlisted to make sure you don't set a forbidden combination.

        handleEvent: (event) ->
            switch event.type
                when "change"
                    switch event.target
                        when @input.message then @setState
                            message: @input.message.value
                            charsLeft: do @getCharsLeft
                        when @input.makePublic then @setState
                            makePublic: @input.makePublic.checked
                            makeListed: @input.makeListed.checked and @input.makePublic.checked
                            forceListed: not @input.makePublic.checked
                        when @input.makeListed then @setState
                            makePublic: @input.makePublic.checked or @input.makeListed.checked
                            makeListed: @input.makeListed.checked
                        when @input.makeNSFW then @setState {makeNSFW: event.target.checked}
                        when @input.useMessage then @setState {useMessage: event.target.checked}

When a user clicks the "Post" button, we fire off a `Composer.Post` event with our data, wipe (almost) everything, and tell the composer to close.
Public/private and listed/unlisted settings are maintained for the next post.

                when "click"
                    if event.target is @input.post and do @getCharsLeft >= 0
                        Laboratory.dispatch "LaboratoryPostComposed",
                            text: @state.text
                            message: if @state.useMessage then @state.message else null
                            makePublic: @state.makePublic
                            makeListed: @state.makeListed
                            makeNSFW: @state.makeNSFW
                            inReplyTo: @state.inReplyTo
                        @setState
                            replyStatus: null
                            text: "\n"
                            message: ""
                            inReplyTo: undefined
                            charsLeft: @props.maxChars
                            useMessage: false
                            makeNSFW: false
                            forceNSFW: true
                            shouldClose: true

###  Rendering:

Our `render()` function is huge, but most of it is just buttons and their corresponding icons and labels.
Some things to note:

1.  With our inputs aside from our text box, we use `getRef` and not `ref` because it gives us the underlying `<input>`/`<button>` element.

2.  The `"aria-label"` attribute is used to hold our placeholder text.
    This isn't *always* okay, but since our placeholder also describes the textbox, in our case it is.

3.  The `onChange` attribute on our textbox doesn't link to an event listener since in this instance `onChange` doesn't actually produce an event.
    It's just a callback that gets passed the value of the textbox whenever it updates.

4.  If our `visible` property is false then we don't render anything.
    The advantage to this approach over simply not mounting the component is that lit lets us keep our state persistent—in case someone wants to go back and look at a user's account before finishing their thought, for example.

With those things in mind, here's the function:

        render: ->
            return null unless @props.visible and (not @state.inReplyTo or @state.replyStatus?.id is @state.inReplyTo)
            彁 Modules.Module, {attributes: {id: "labcoat-composer"}, close: @state.shouldClose},
                彁 "header", null,
                    if @state.account then 彁 Shared.IDCard, {account: @state.account} else null
                彁 Shared.Textbox,
                    id: "labcoat-composertextbox"
                    "aria-label": @context.intl.messages["composer.placeholder"]
                    onChange: ((text) => @setState {text, charsLeft: do @getCharsLeft})
                    value: @format @state.text
                    ref: ((ref) => @input.textbox = ref)
                彁 "footer", null,
                    彁 "span", {id: "labcoat-count"}, if isNaN @state.charsLeft then "" else @state.charsLeft
                    彁 Shared.Button,
                        onClick: @handleEvent
                        getRef: ((ref) => @input.post = ref)
                        disabled: @state.charsLeft < 0
                        label: 彁 ReactIntl.FormattedMessage,
                            id: "composer.post"
                            defaultMessage: "Post"
                        icon: "icon.post"
                彁 "aside", {id: "labcoat-composeroptions"},
                    彁 "div", {id: "labcoat-postoptions"},
                        彁 Shared.Toggle,
                            getRef: (ref) => @input.makePublic = ref
                            checked: @state.makePublic
                            onChange: @handleEvent
                            inactiveText: 彁 ReactIntl.FormattedMessage,
                                id: "composer.private"
                                defaultMessage: "Private"
                            inactiveIcon: "icon.private"
                            activeIcon: "icon.public"
                            activeText: 彁 ReactIntl.FormattedMessage,
                                id: "composer.public"
                                defaultMessage: "Public"
                        彁 Shared.Toggle,
                            getRef: (ref) => @input.makeListed = ref
                            checked: @state.makeListed
                            onChange: @handleEvent
                            inactiveText: 彁 ReactIntl.FormattedMessage,
                                id: "composer.unlisted"
                                defaultMessage: "Unlisted"
                            inactiveIcon: "icon.unlisted"
                            activeIcon: "icon.listed"
                            activeText: 彁 ReactIntl.FormattedMessage,
                                id: "composer.listed"
                                defaultMessage: "Listed"
                        彁 Shared.Toggle,
                            getRef: (ref) => @input.makeNSFW = ref
                            checked: @state.makeNSFW
                            onChange: @handleEvent
                            disabled: @state.forceNSFW
                            inactiveText: 彁 ReactIntl.FormattedMessage,
                                id: "composer.sfw"
                                defaultMessage: "Safe"
                            inactiveIcon: "icon.sfw"
                            activeIcon: "icon.nsfw"
                            activeText: 彁 ReactIntl.FormattedMessage,
                                id: "composer.nsfw"
                                defaultMessage: "Sensitive"
                    彁 "div", {id: "labcoat-hideoptions"},
                        彁 Shared.Toggle,
                            getRef: (ref) => @input.useMessage = ref
                            checked: @state.useMessage
                            onChange: @handleEvent
                            inactiveText: ""
                            inactiveIcon: "icon.nomessage"
                            activeIcon: "icon.message"
                            activeText: 彁 ReactIntl.FormattedMessage,
                                id: "composer.message"
                                defaultMessage: "Hide behind message"
                        彁 "input",
                            type: "text"
                            placeholder: @context.intl.messages["composer.nomessage"]
                            value: @state.message
                            ref: (ref) => @input.message = ref
                            onChange: @handleEvent






#  SHARED  #

##  Implementation  ##

    Shared = {}


#  `Shared.Action`  #

##  Usage  ##

>   ```jsx
>       <Action
>           active=React.PropTypes.boolean
>           icon=React.PropTypes.string.isRequired
>           label=React.PropTypes.element||React.PropTypes.string
>           getRef=React.PropTypes.func
>           className=React.PropTypes.string
>       />
>   ```
>   Creates an `Action` component, which renders a labelled button for use with particular actions. Some of the accepted properties are:
>   -   **`active` [OPTIONAL `boolean`] :**
>       The action's icon.
>   -   **`icon` [REQUIRED `string`] :**
>       The action's icon.
>   -   **`label` [OPTIONAL `element` or `string`] :**
>       The action's label, rendered beside it.
>   -   **`getRef` [OPTIONAL `function`] :**
>       A callback which receives a reference to the action's `<button>` element.
>   -   **`className` [OPTIONAL `string`] :**
>       A class name to apply to the action container.
>   -   **`action` [OPTIONAL `function`] :**
>       A callback to call when the element is clicked.

##  The Component  ##

The `Action` component is just a simple React component which displays a button for causing an action.
It passes its properties to the `<button>` element it creates.

    Shared.Action = React.createClass

        mixins: [ReactPureRenderMixin]

        propTypes:
            active: React.PropTypes.bool
            icon: React.PropTypes.string.isRequired
            label: React.PropTypes.oneOfType [
                React.PropTypes.element
                React.PropTypes.string
            ]
            getRef: React.PropTypes.func
            className: React.PropTypes.string
            action: React.PropTypes.func

        getDefaultProps: ->
            active: false
            label: ""
            action: ->

        action: null

        componentDidMount: -> @props.getRef @action if @props.getRef

        render: ->
            output_props =
                className: "labcoat-action"
                ref: (ref) => @action = ref
            for own key, val of @props
                output_props[key] = val if (["className", "getRef", "ref", "label", "icon", "containerClass"].indexOf key) is -1
            彁 "label", {className: "labcoat-actioncontainer" + (if @props.className then " " + @props.className else "") + (if @props.disabled then " labcoat-actioncontainer--disabled" else "") + (if @props.active then " labcoat-actioncontainer--active" else ""), onClick: @props.action},
                @props.label
                彁 "button", output_props,
                    彁 Shared.Icon, {name: @props.icon}


#  `Shared.Button`  #

##  Usage  ##

>   ```jsx
>       <Button
>           icon=React.PropTypes.string.isRequired
>           label=React.PropTypes.element||React.PropTypes.string
>           getRef=React.PropTypes.func
>           containerClass=React.PropTypes.string
>       />
>   ```
>   Creates a `Button` component, which renders a labelled button. Some of the accepted properties are:
>   -   **`icon` [REQUIRED `string`] :**
>       The button's icon.
>   -   **`label` [OPTIONAL `element` or `string`] :**
>       The button's label, rendered beside it.
>   -   **`getRef` [OPTIONAL `function`] :**
>       A callback which receives a reference to the button's `<button>` element.
>   -   **`containerClass` [OPTIONAL `string`] :**
>       A class name to apply to the button container.

##  The Component  ##

The `Button` component is just a simple React component which displays a button inside a label.
It passes its properties to the `<button>` element it creates.

    Shared.Button = React.createClass

        mixins: [ReactPureRenderMixin]

        propTypes:
            icon: React.PropTypes.string.isRequired
            label: React.PropTypes.oneOfType [
                React.PropTypes.element
                React.PropTypes.string
            ]
            getRef: React.PropTypes.func
            containerClass: React.PropTypes.string

        getDefaultProps: ->
            label: ""

        button: null

        componentDidMount: -> @props.getRef @button if @props.getRef

        render: ->
            output_props =
                className: "labcoat-button"
                ref: (ref) => @button = ref
            for own key, val of @props
                if key is "className" then output_props[key] += " " + val
                else if (["getRef", "ref", "label", "icon", "containerClass"].indexOf key) is -1 then output_props[key] = val
            彁 "label", {className: "labcoat-buttoncontainer" + (if @props.containerClass then " " + @props.containerClass else "") + (if @props.disabled then " labcoat-buttoncontainer--disabled" else "")},
                @props.label
                彁 "button", output_props,
                    彁 Shared.Icon, {name: @props.icon}


#  `Shared.Icon`  #

##  Usage  ##

>   ```jsx
>       <Icon
>           name=React.PropTypes.string.isRequired
>       />
>   ```
>   Creates an `Icon` component, which provides a fontawesome icon. The accepted properties are:
>   -   **`name` [REQUIRED `string`] :**
>       The message used to acquire the icon.

##  The Component  ##

The `Icon` is just a simple React component.

    Shared.Icon = React.createClass

        mixins: [ReactPureRenderMixin]

        propTypes:
            name: React.PropTypes.string.isRequired

We will need `intl` from the React context in order to access the composer placeholder text.

        contextTypes:
            intl: React.PropTypes.object.isRequired

        render: ->
            彁 'i',
                className: "fa fa-fw fa-" + (@context.intl.messages[@props.name] || @props.name)
                "aria-hidden": true


#  `Shared.IDCard`  #

##  Usage  ##

>   ```jsx
>       <IDCard
>           account=React.PropTypes.object
>           externalLinks=React.PropTypes.bool
>       />
>   ```
>   Creates a `IDCard` component, which contains identification information for a status/post. The accepted properties are:
>   -   **`account` [REQUIRED `object`] :**
>       The account to identify.
>   -   **`externalLinks` [OPTIONAL `boolean`] :**
>       Whether to use internal or external links for the account page.

##  The Component  ##

The `IDCard` is just a simple functional React component.

    Shared.IDCard = (props) ->
        return null unless props.account instanceof Object
        彁 'div', {className: "labcoat-idcard"},
            彁 (if props.externalLinks then ["a", {href: props.account.avatar, target: "_blank"}] else [ReactRouter.Link, {to: "user/" + props.account.id, title: props.account.displayName}])...,
                彁 'img', {className: "labcoat-avatar", src: props.account.avatar, alt: props.account.displayName}
            彁 (if props.externalLinks then ["a", {href: props.account.href, title: props.account.displayName, target: "_blank"}] else [ReactRouter.Link, {to: "user/" + props.account.id, title: props.account.displayName}])...,
                彁 'b', {className: "labcoat-displayname"}, props.account.displayName
                彁 'code', {className: "labcoat-username"}, props.account.localAccount

    Shared.IDCard.propTypes =
        account: React.PropTypes.object.isRequired
        externalLinks: React.PropTypes.bool


#  `Shared.Textbox`  #

##  Usage  ##

>   ```jsx
>       <Textbox
>           getRef=React.PropTypes.func
>           onChange=React.PropTypes.func
>           placeholder=React.PropTypes.string
>           value=React.PropTypes.string
>           formatting=React.PropTypes.func
>       />
>   ```
>   Creates a `Textbox` component, which renders a toggle. Some of the accepted properties are:
>   -   **`getRef` [OPTIONAL `function`] :**
>       A callback which receives a reference to the textbox's `<root>` element.
>   -   **`onInput` [OPTIONAL `function`] :**
>       A function to call when the element receives an input.
>   -   **`aria-label` [OPTIONAL `string`] :**
>       The label for the textbox.
>   -   **`value` [OPTIONAL `string`] :**
>       The plain-text value of the textbox.
>   -   **`formatting` [OPTIONAL `func`] :**
>       Code to handle the formatting of the value before it is rendered.

##  The Component  ##

The `Textbox` component provides a semi-rich-text editor.
We store the plain-text `value` of the textbox in an instance variable and then pass it up to its parent component through `onChange`.
Similarly, the `value` property passed down contains HTML-formatted content with which to update our box.

    Shared.Textbox = React.createClass

        propTypes:
            getRef: React.PropTypes.func
            onChange: React.PropTypes.func
            className: React.PropTypes.string
            id: React.PropTypes.string
            'aria-label': React.PropTypes.string
            value: React.PropTypes.string

        getDefaultProps: ->
            value: "<br>"

        componentDidMount: ->
            @props.getRef @input if @props.getRef?
            @value = do @getContents

        caret: 0
        value: "\n"

###  Event handling:

For the most part, we just call `getContents()` to update our `value` whenever something happens to our textbox.
However, if the user types "enter" then we need to ensure that the result is just a simple `<br>` line feed and not some weird `<div>`-induced magic that browsers like Chrome like to pull.

        handleEvent: (event) ->
            return unless (event.type is "input" or event.type is "blur" or event.type is "keypress") and event.target is @input
            if event.type is "keypress"
                if event.key is "Enter" or event.code is "Enter" or event.keyCode is 0x0D
                    do event.preventDefault
                    sel = do window.getSelection
                    rng = sel.getRangeAt 0
                    do rng.deleteContents
                    rng.insertNode br = document.createElement "br"
                    rng.setEndAfter br
                    rng.collapse false
                    do sel.removeAllRanges
                    sel.addRange rng
                else return
            @value = do @getContents
            @props.onChange @value if @props.onChange

###  Retrieving textbox contents:

This is a little more complicated than it should be since we have to account for `<br>`s.
We walk the tree of our textbox and collect the content of every text node, but also insert a `"\n"` for each `<br>` we find.
So, this is a `<br>`-aware `Element.textContent`.

        getContents: ->
            wkr = document.createTreeWalker @input
            nde = null
            out = ""
            while (do wkr.nextNode)?
                nde = wkr.currentNode
                if nde.nodeType is Node.TEXT_NODE then out += nde.textContent
                else if nde.nodeType is Node.ELEMENT_NODE and do nde.tagName.toUpperCase() is "BR" then out += "\n"
            out += "\n" if out.length and (out.slice -1) isnt "\n"
            return out

###  Updating the DOM only when necessary:

React will try to update the DOM every time there's a property change but we actually only need to do that if the formatted HTML we produce isn't the same as the HTML we already have.
Checking for this means that we don't have to do our complicated TreeWalkers to update the caret position nearly so often.

        shouldComponentUpdate: (nextProps, nextState) -> @props.value isnt @input.innerHTML

###  Getting the caret position:

This script gets our current caret position, so we can put it back after we insert our formatted text.

        updateCaretPos: ->

            @caret = 0

We store the current selection with `sel` and the current range of the selection with `rng`.

            sel = do window.getSelection
            rng = sel.getRangeAt 0

`pre` is a range consisting of everything leading up to the end of `rng`.
First we select our entire text area, and then we set the endpoint of the range to be the endpoint of our current selection.

            pre = do rng.cloneRange
            pre.selectNodeContents @input
            pre.setEnd rng.endContainer, rng.endOffset

This next line tells us how many line breaks were in the selected range.
This is a somewhat expensive operation as it involves cloning DOM nodes, but there isn't any faster way.

            brs = ((do pre.cloneContents).querySelectorAll "br").length

We can now find the length of the selection by adding the text content to the number of line breaks.

            @caret = (do pre.toString).length + brs
            do pre.detach
            return

###  Mangaing caret position before and after updating:

We use `componentWillUpdate` to grab the caret position right before updating, and `componentDidUpdate` to set it right after.

        componentWillUpdate: -> do @updateCaretPos

We're going to use a `TreeWalker` to walk the contents of our textbox until we find the correct position to stick our caret.

        componentDidUpdate: ->
            sel = do window.getSelection
            rng = do document.createRange
            wkr = document.createTreeWalker @input
            idx = 0
            nde = null
            success = false

If our caret is as long as our `value`, we can cut straight to the chase and stick our caret at the end.

            success = true if @caret >= @value.length - 1

This loop breaks when either we run out of nodes, or we find the text node that our caret belongs in.
It will also break if we wind up in-between two `<br>`s, as that is a possibility.

            loop
                break unless (do wkr.nextNode)?
                nde = wkr.currentNode
                if nde.nodeType is Node.TEXT_NODE
                    if idx <= @caret <= idx + nde.textContent.length
                        success = true
                        break
                    else idx += nde.textContent.length
                else if nde.nodeType is Node.ELEMENT_NODE and do nde.tagName.toUpperCase is "BR"
                    if idx++ is @caret
                        success = true
                        break
                else continue

If we were successfull, we set the end of our range to the point we found.
If we weren't, we select the textbox's entire contents, save the final `<br>`, if present.
Either way, we collapse the range to its endpoint and move the caret there.

            if success and nde
                if nde.nodeType is Node.TEXT_NODE then rng.setEnd nde, @caret - idx else rng.selectNodeContents nde
            else if @input.lastChild?.nodeName.toUpperCase is "BR" then rng.setEnd @input, @input.childNodes.length - 1
            else rng.selectNodeContents @input
            rng.collapse false
            do sel.removeAllRanges
            sel.addRange rng

###  Rendering

For all its complexity, `Textbox` is just a single `<div>`.
We set it's contents through `dangerouslySetInnerHTML`, which would normally be slower than just sticking them in directly (through `node.appendChild`) except that we're already dealing with `innerHTML`s when we call `shouldComponentUpdate()`, above.

        render: ->
            output_props =
                className: "labcoat-textbox" + (if do @props.value.toLowerCase is "<br>" or @props.value is "\n" or @props.value is "" then " labcoat-textbox--empty" else "") + (if @props.className? then " " + @props.className else "")
                contentEditable: true
                onKeyPress: @handleEvent
                onInput: @handleEvent
                onBlur: @handleEvent
                ref: (ref) => @input = ref
                dangerouslySetInnerHTML:
                    __html: @props.value
            output_props[key] = value for own key, value of @props when (["className", "contentEditable", "value", "getRef", "onChange", "onInput", "onBlur", "dangerouslySetInnerHTML", "ref"].indexOf key) is -1
            彁 "div", output_props


#  `Shared.Toggle`  #

##  Usage  ##

>   ```jsx
>       <Toggle
>           getRef=React.PropTypes.func
>           activeText=React.PropTypes.element||React.PropTypes.string
>           inactiveText=React.PropTypes.element||React.PropTypes.string
>           activeIcon=React.PropTypes.string
>           inactiveIcon=React.PropTypes.string
>       >
>           {/*  content  */}
>       </Toggle>
>   ```
>   Creates a `Toggle` component, which renders a toggle. Some of the accepted properties are:
>   -   **`getRef` [OPTIONAL `function`] :**
>       A callback which receives a reference to the toggle's `<input>` element.
>   -   **`activeText` [OPTIONAL `element` or `string`] :**
>       The text label for the active toggle state.
>   -   **`inactiveText` [OPTIONAL `element` or `string`] :**
>       The text label for the inactive toggle state.
>   -   **`activeIcon` [OPTIONAL `element` or `string`] :**
>       The icon for the active toggle state.
>   -   **`inactiveIcon` [OPTIONAL `element` or `string`] :**
>       The icon for the inactive toggle state.

##  The Component  ##

The `Toggle` component is a minimal re-implimentation of [`react-toggle`](https://github.com/aaronshaf/react-toggle) with additional features regarding text labels.

    Shared.Toggle = React.createClass

        mixins: [ReactPureRenderMixin]

        propTypes:
            checked: React.PropTypes.bool
            disabled: React.PropTypes.bool
            onChange: React.PropTypes.func
            className: React.PropTypes.string
            name: React.PropTypes.string
            value: React.PropTypes.string
            id: React.PropTypes.string
            'aria-labelledby': React.PropTypes.string
            'aria-label': React.PropTypes.string
            getRef: React.PropTypes.func
            activeText: React.PropTypes.oneOfType [
                React.PropTypes.element
                React.PropTypes.string
            ]
            inactiveText: React.PropTypes.oneOfType [
                React.PropTypes.element
                React.PropTypes.string
            ]
            activeicon: React.PropTypes.string
            inactiveicon: React.PropTypes.string

        getDefaultProps: ->
            activeText: 彁 ReactIntl.FormattedMessage,
                id: "toggle.on"
                defaultMessage: "On"
            inactiveText: 彁 ReactIntl.FormattedMessage,
                id: "toggle.off"
                defaultMessage: "Off"
            activeIcon: "icon.on"
            inactiveIcon: "icon.off"

        getInitialState: ->
            checked: !!@props.checked
            disabled: !!@props.disabled
            hasFocus: false

        componentWillReceiveProps: (nextProps) ->
            @setState {checked: !!nextProps.checked} if nextProps.checked?
            @setState {disabled: !!nextProps.disabled} if nextProps.disabled?
            return

        componentDidMount: -> @props.getRef(@input) if @props.getRef?

        handleEvent: (event) ->
            switch event.type
                when "click"
                    unless event.target is @input
                        do event.preventDefault
                        do @input.focus
                        do @input.click
                    @setState {checked: @input.checked}
                when "onFocus"
                    @setState {hasFocus: true}
                    @props.onFocus event if @props.onFocus
                when "onBlur"
                    @setState {hasFocus: false}
                    @props.onBlur event if @props.onBlur

        render: ->
            output_props = {className: "labcoat-toggle-screenreader-only", type: "checkbox", onFocus: @handleEvent, onBlur: @handleEvent, ref: (ref) => @input = ref}
            output_props[key] = value for own key, value of @props when (["className", "activeText", "activeIcon", "inactiveText", "inactiveIcon", "getRef", "ref", "type", "onFocus", "onBlur"].indexOf key) is -1
            彁 "label", {className: "labcoat-toggle" + (if @state.checked then " labcoat-toggle--checked" else "") + (if @state.disabled then " labcoat-toggle--disabled" else "") + (if @state.hasFocus then " labcoat-toggle--focus" else "") + (if @props.className then " " + @props.className else ""), onClick: @handleEvent},
                彁 "span", {className: "labcoat-toggle-label labcoat-toggle-label-off"}, @props.inactiveText
                彁 "div", {className: "labcoat-toggle-track"},
                    彁 "div", {className: "labcoat-toggle-track-check"},
                        彁 Shared.Icon, {name: @props.activeIcon}
                    彁 "div", {className: "labcoat-toggle-track-x"},
                        彁 Shared.Icon, {name: @props.inactiveIcon}
                    彁 "div", {className: "labcoat-toggle-thumb"}
                    彁 "input", output_props
                彁 "span", {className: "labcoat-toggle-label labcoat-toggle-label-on"}, @props.activeText


#  `Shared.InstanceQuery`  #

##  Usage  ##

>   ```jsx
>       <InstanceQuery
>           locale=React.PropTypes.string.isRequired
>       />
>   ```
>   Creates a simple text input for requesting a user's home instance.

##  The Component  ##

`InstanceQuery` is just a simple React component class.

    Shared.InstanceQuery = React.createClass

        mixins: [ReactPureRenderMixin]

        propTypes:
            locale: React.PropTypes.string.isRequired
            title: React.PropTypes.string
            basename: React.PropTypes.string

        getDefaultProps: ->
            title: "Labcoat"
            basename: "/web"

        getInitialState: ->
            value: ""

###  Handling input:

This is a pretty straightforward input handler for React.
The only tricky bit is that when the user presses the enter key, we dispatch a `LaboratoryAuthorizationRequested` event with the url they provided.

        input: null

        handleEvent: (event) ->
            if event.type is "change" and event.target is @input then @setState {value: @input.value}
            else if event.type is "keypress" and event.target is @input and (event.key is "Enter" or event.code is "Enter" or event.keyCode is 0x0D) and @input.value.length and @input.validity.valid
                window.open "about:blank", "LaboratoryOAuth"
                Laboratory.dispatch "LaboratoryAuthorizationRequested",
                    name: @props.title
                    url: "https://" + @input.value
                    redirect: @props.basename
                    scope: Laboratory.Authorization.Scope.READWRITEFOLLOW
                @setState {value: ""}
            return

###  Rendering:

        render: ->

…And here's what we render:

            return 彁 ReactIntl.IntlProvider, {locale: @props.locale, messages: Locales[@props.locale]},
                彁 "div", {id: "labcoat-instancequery"},
                    彁 ReactIntl.FormattedMessage,
                        id: "instancequery.queryinstance"
                        defaultMessage: "What's your instance?"
                    彁 "div", {id: "labcoat-instancequeryinput"},
                        彁 "code", {className: "labcoat-username"}, "username@"
                        彁 "input",
                            type: "text"
                            pattern: "[0-9A-Za-z\-\.]+(\:[0-9]{1,4})?"
                            placeholder: "example.com"
                            value: @state.value
                            ref: (ref) => @input = ref
                            onChange: @handleEvent
                            onKeyPress: @handleEvent


#  `Shared.Frontend`  #

##  Usage  ##

>   ```jsx
>       <Frontend
>           locale=React.PropTypes.string.isRequired
>           myID=React.PropTypes.number.isRequired
>           useBrowserHistory=React.PropTypes.bool
>           title=React.PropTypes.string
>           links=React.PropTypes.object
>           basename=React.PropTypes.string
>           maxChars=React.PropTypes.number
>           defaultPrivacy=React.PropTypes.string
>       />
>   ```
>   Creates a `Frontend` component, which acts as a container for the entire frontend. The accepted properties are:
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
>   -   **`basename` [OPTIONAL `string`] :**
>       The base URL to use with the React router. Defaults to '/web'.
>   -   **`maxChars` [OPTIONAL `string`] :**
>       The maximum number of characters to allow in a post. Defaults to 500.
>   -   **`defaultPrivacy` [OPTIONAL `string`] :**
>       The default privacy setting. Defaults to "unlisted".

##  Imports  ##

Not really an import, but here's some convenience stuff for `react-router`.

    {Router, Route, IndexRoute} = ReactRouter

##  The Component  ##

`Frontend` is just a React component class.
Here we define the initial properties, as above.

    Shared.Frontend = React.createClass

        mixins: [ReactPureRenderMixin]

        propTypes:
            locale: React.PropTypes.string.isRequired
            myID: React.PropTypes.number.isRequired
            title: React.PropTypes.string
            links: React.PropTypes.object
            basename: React.PropTypes.string
            maxChars: React.PropTypes.number
            useBrowserHistory: React.PropTypes.bool
            defaultPrivacy: React.PropTypes.string

        getDefaultProps: ->
            title: "Labcoat"
            basename: "/web"
            maxChars: 500
            defaultPrivacy: "unlisted"
            useBrowserHistory: true

        getInitialState: ->
            thirdColumn: 彁 Columns.Empty
            showComposer: no
            composerQuery: null

###  Third column processing:

The component displayed in the third column varies as the user navigates around the site.
The function `setThirdColumn` allows us to manage this ourselves.

        setThirdColumn: (component, props) -> @setState {thirdColumn: 彁 component, props}

        getThirdColumn: -> @state.thirdColumn

###  Composer processing:

        showComposer: (nextState) ->
            @setState
                showComposer: yes
                composerQuery: nextState.location.query || null

        hideComposer: ->
            @setState
                showComposer: no
                composerQuery: null

###  Loading:

`componentWillMount` tells React what to do once our engine is about to load.

        componentWillMount: ->

This starts tracking our browser history for our router:

            @history = (if @props.useBrowserHistory then ReactRouter.useRouterHistory History.createHistory else ReactRouter.useRouterHistory History.createHashHistory) {basename: @props.basename}

####  Pre-caluclating routes.

The React router will issue a warning in the console if you try modifying its routes after the inital render.
This is a problem because every time our state changes, `render()` will re-create our arrow functions and React will interpret this as an attempted change.
By calculating our routes ahead of time, we avoid this problem.

            @routes = 彁 Route, {path: '/', component: (props) => 彁 UI.UI, {title: @props.title, maxChars: @props.maxChars, defaultPrivacy: @props.defaultPrivacy, thirdColumn: do @getThirdColumn, myID: @props.myID, showComposer: @state.showComposer, composerQuery: @state.composerQuery}, props.children},

                #  Go:

                彁 IndexRoute, {onEnter: => @setThirdColumn Columns.Go, {footerLinks: @props.links, myID: @props.myID}}

                #  Start:

                彁 Route, {path: 'start', onEnter: => @setThirdColumn Modules.Start}

                #  Timelines:

                彁 Route, {path: 'global', onEnter: => @setThirdColumn Columns.Timeline, {name: 'global'}}
                彁 Route, {path: 'community', onEnter: => @setThirdColumn Columns.Timeline, {name: 'community'}}
                彁 Route, {path: 'hashtag/:id', onEnter: (nextState) => @setThirdColumn Columns.Timeline, {name: 'hashtag/' + nextState.params.id}}
                彁 Route, {path: 'favourites', onEnter: => @setThirdColumn Columns.Timeline, {name: 'favourites'}}

                #  Statuses:

                彁 Route, {path: 'compose(?**)', onEnter: ((nextState) => @showComposer nextState), onLeave: => @hideComposer()}
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
                do @subscription.close
                @subscription = undefined
            return

###  Rendering:

OKAY OKAY TIME TO RENDER.
Let's go!

        render: ->

…And here's what we render:

            return 彁 ReactIntl.IntlProvider, {locale: @props.locale, messages: Locales[@props.locale]},
                彁 Router, {history: @history},
                    @routes


#  UI  #

##  Implementation  ##

    UI = {}


#  `UI.Header`  #

##  Usage  ##

>   ```jsx
>       <Header
>           title=React.PropTypes.string
>       />
>   ```
>   Creates a `Header` component, which contains various user actions. The accepted properties are:
>   -   **`title` [OPTIONAL `string`] :**
>       The title of the site

##  The Component  ##

The `Header` is just a simple functional React component.

    UI.Header = (props) ->
        彁 'header', {id: "labcoat-header"},
            彁 UI.Title, null,
                props.title
            彁 ReactRouter.Link, {to: "/compose"},
                彁 Shared.Button,
                    icon: "icon.compose"
                    label: 彁 ReactIntl.FormattedMessage,
                        id: "composer.compose"
                        defaultMessage: "Compose"

    UI.Header.propTypes =
        title: React.PropTypes.string


#  `UI.Title`  #

##  Usage  ##

>   ```jsx
>       <Title>
>           {/* content */}
>       </Title>
>   ```
>   Creates a `Title` component, which links back to the homepage.

##  The Component  ##

The `Title` is just a simple functional React component.

    UI.Title = (props) ->
        彁 'h1', null,
            彁 ReactRouter.Link, {to: "/"},
                props.children


#  `UI.UI`  #

##  Usage  ##

>   ```jsx
>       <UI
>           title=React.PropTypes.string
>           maxchars=React.PropTypes.number.isRequired
>           myID=React.PropTypes.number.isRequired
>           defaultPrivacy=React.PropTypes.string
>           thirdColumn=React.PropTypes.element.isRequired
>           showComposer=React.PropTypes.bool
>           composerQuery=React.PropTypes.object
>       >
>           {/* content */}
>       </UI>
>   ```
>   Creates a `UI` component, which contains the entire rendered frontend. The accepted properties are:
>   -   **`title` [OPTIONAL `string`] :**
>       The title of the site.
>   -   **`maxChars` [REQUIRED `number`] :**
>       The maximum number of characters to allow in a post.
>   -   **`myID` [REQUIRED `number`] :**
>       The account id for the currently signed-in user.
>   -   **`defaultPrivacy` [OPTIONAL `string`] :**
>       The default privacy setting.
>   -   **`thirdColumn` [REQUIRED `element`] :**
>       The component to display in the third column.
>   -   **`showComposer` [OPTIONAL `boolean`] :**
>       Whether or not to show the composer.
>   -   **`composerQuery` [OPTIONAL `object`] :**
>       Query parameters to initialize the composer.

##  The Component  ##

Our UI doesn't have any properties except for its `title` and children.

    UI.UI = React.createClass

        mixins: [ReactPureRenderMixin]

        propTypes:
            title: React.PropTypes.string
            maxChars: React.PropTypes.number.isRequired
            myID: React.PropTypes.number.isRequired
            thirdColumn: React.PropTypes.element.isRequired
            showComposer: React.PropTypes.bool
            composerQuery: React.PropTypes.object

###  Event handling:

Here we will handle events related to the UI:

        handleEvent: (e) ->
            switch e.type

####  Drag-and-drop.

This handles our drag-and-drop events:

                when "dragenter" then (document.getElementById "labcoat-ui").setAttribute "data-laboratory-dragging", ""
                when "dragover"
                    do e.preventDefault
                    e.dataTransfer.dropEffect = "copy"
                when "dragleave" then (document.getElementById "labcoat-ui").removeAttribute "data-laboratory-dragging" unless e.relatedTarget?
                when "drop"
                    do e.preventDefault
                    (document.getElementById "labcoat-ui").removeAttribute "data-laboratory-dragging"
                    # Laboratory.Composer.UploadRequested.dispatch {file: e.dataTransfer.files.item 1} if e.dataTransfer and e.dataTransfer.files.length is 1


###  Loading:

Here we add our event listeners.

        componentWillMount: ->
            document.addEventListener "dragenter", this
            document.addEventListener "dragover", this
            document.addEventListener "dragleave", this
            document.addEventListener "drop", this

###  Unloading:

We can remove our event listeners if we're unloading our UI.

        componentWillUnmount: ->
            document.removeEventListener "dragenter", this
            document.removeEventListener "dragover", this
            document.removeEventListener "dragleave", this
            document.removeEventListener "drop", this

###  Rendering:

        render: ->
            彁 'div', {id: "labcoat-ui"},
                彁 UI.Header, {title: @props.title}
                彁 Columns.Timeline, {name: "home"}
                彁 Columns.Timeline, {name: "notifications"}
                @props.thirdColumn
                @props.children
                彁 Modules.Composer,
                    defaultPrivacy: @props.defaultPrivacy
                    myID: @props.myID
                    maxChars: @props.maxChars
                    visible: @props.showComposer
                    text: @props.composerQuery?.text
                    inReplyTo: if isFinite @props.composerQuery?.inReplyTo then Number @props.composerQuery.inReplyTo else undefined


#  LOCALES  #

##  Implementation  ##

    Locales = {}


    Locales.en =

        "timeline.home": "Home"
        "timeline.community": "Community"
        "timeline.global": "Global"
        "timeline.notifications": "Notifications"

        "composer.compose": "Compose"
        "composer.post": "Post"
        "composer.private": "Private"
        "composer.public": "Public"
        "composer.unlisted": "Unlisted"
        "composer.listed": "Listed"
        "composer.sfw": "Safe"
        "composer.nsfw": "Sensitive"
        "composer.nomessage": "…… ……"
        "composer.message": "Hide behind message"
        "composer.placeholder": "What's going on?"

        "account.follow": "Follow"
        "account.unfollow": "Unfollow"
        "account.blocking": "Blocking"
        "account.request": "Request Follow"
        "account.requested": "Request Sent"
        "account.statuses": "Posts"
        "account.following": "Follows"
        "account.followers": "Followers"

        "status.and": "and"
        "status.etal": "et al."
        "status.reblog": "Boost"
        "status.unreblog": "Unboost"
        "status.noreblog": "Private"
        "status.favourite": "Highlight"
        "status.unfavourite": "Unhighlight"
        "status.reply": "Reply"
        "status.followedyou": "followed you!"
        "status.rebloggedthisreplyto": "boosted this reply to"
        "status.rebloggedthisreply": "boosted this reply"
        "status.rebloggedthisstatus": "boosted this post"
        "status.favouritedthisreplyto": "highlighted this reply to"
        "status.favouritedthisreply": "highlighted this reply"
        "status.favouritedthisstatus": "highlighted this post"
        "status.inreplyto": "In reply to"
        "status.inreplytoself": "In reply to themselves"

        "go.heading": "let's GO!"
        "go.profile": "Profile"
        "go.community": "Community"
        "go.global": "Global"

        "notfound.notfound": "Not found"

        "toggle.off": "Off"
        "toggle.on": "On"

        "icon.home": "home"
        "icon.community": "users"
        "icon.global": "link"
        "icon.hashtag": "hashtag"
        "icon.user": "at"
        "icon.notifications": "star-half-o"
        "icon.mystery": "question-circle"
        "icon.notfound": "exclamation-triangle"
        "icon.go": "arrow-right"
        "icon.profile": "list-alt"
        "icon.reblog": "plus-square"
        "icon.unreblog": "minus-square"
        "icon.noreblog": "square-o"
        "icon.favourite": "pencil"
        "icon.unfavourite": "eraser"
        "icon.reply": "reply"
        "icon.follow": "user-plus"
        "icon.unfollow": "user-times"
        "icon.blocked": "ban"
        "icon.request": "user-secret"
        "icon.requested": "share-square"
        "icon.post": "paper-plane-o"
        "icon.private": "microphone-slash"
        "icon.public": "rss"
        "icon.unlisted": "envelope-o"
        "icon.listed": "newspaper-o"
        "icon.sfw": "picture-o"
        "icon.nsfw": "exclamation"
        "icon.nomessage": "ellipsis-h"
        "icon.message": "question-circle-o"
        "icon.on": "check-circle-o"
        "icon.off": "times"
        "icon.compose": "pencil-square-o"

        "character.space": " "
        "character.comma": ", "


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
            "Nº" : 2.0
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

            if config.accessToken then Laboratory.dispatch "LaboratoryAuthorizationGranted",
                accessToken: config.accessToken
                origin: config.origin
                scope: Authorization.Scope.READWRITEFOLLOW

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
                Laboratory.forget "LaboratoryAuthorizationReceived", callback

            Laboratory.listen "LaboratoryAuthorizationReceived", callback
            Laboratory.forget "LaboratoryInitializationReady", callback

###  Running asynchronously:

We need to wait for Laboratory before we can load our frontend.

        if Laboratory?.ready then do run else Laboratory.listen "LaboratoryInitializationReady", run
