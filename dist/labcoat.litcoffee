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

##  Style Guide  ##

This section describes the style conventions you are likely to encounter when reading Labcoat source.

###  Markdown:

Except where otherwise noted, prose should attempt to follow the Chicago Manual of Style.
Em dashes with no surrounding spaces are used for parantheticals.
Abbreviations are written either all-lowercase or all-uppercase, with the former preferred except at the beginning of sentences, and no trailing period (eg: url, id, html).
The following sections provide more information on Markdown-specific conventions.

####  Headings.

Headings should always be indicated using hash marks, as shown in the code below.
Place two spaces between the hash marks and the heading text.

```markdown
    #  THIS IS A TITLE  #
    ##  This Is A H2 Heading  ##
    ###  This is a H3 heading:
    ####  This is a H4 heading.
    #####  THIS IS A H5 HEADING
    ######  this is a h6 heading
```

####  Paragraphs.

Markdown paragraphs are written with one sentence per line.
This helps document which sentences have changed when looking at git diffs.
Don't break a sentence across multiple lines; similarly, don't put more than one sentence on the same line.

####  Lists.

Markdown lists come in two forms: expanded and condensed.
Condensed lists look like this:

- This is an unnumbered list item.
    - This is a sub-item.
- Note that there is a space before and after the list, but not in-between items.
- Never use a condensed list for something more than one sentence long.

Expanded lists look like this:

 -  This is an expanded list.
    Use this for lists that contain multiple sentences.

 -  You'll notice that there is a blank line between each list item.
    This renders each list as a paragraph.

1.  Numbered lists should always be rendered in an expanded form.

2.  Even though Markdown doesn't require it, try to keep numbering accurate for numbered lists.

####  Code blocks.

Code blocks in source code files should always be placed inside blockquotes using GFM fenced code syntax, like this:

>   ```coffeescript
>       -> "Here is some CoffeeScript code."
>   ```

Literate CoffeeScript will interpret any indented lines as source code, so encapsulating documentation code in blockquotes helps keep everything nicely separated.

#####  LANGUAGES

Labcoat is written in CoffeeScript, but documentation code should be written instead using plain JavaScript.
Knowledge of CoffeeScript should not be a prerequisite for interfacing with the Laboratory engine.

Labcoat's source doesn't use JSX, but for conciseness its documentation *should*.

####  Issues and notes.

If you want to reference an open issue, or make a note, the syntax for this is as follows:

>   __Note :__
>   This is a note.

Note the space between the colon and the word "Note".
Again, each sentence should be on its own line.
If the issue has a GitHub link, you might include that:

>   __[Issue #XX](https://github.com/marrus-sh/labcoat/issues/XX) :__
>   Here is a comment regarding that issue

Following this syhtax will make finding references to notes and issues easy when searching through pages of source.

####  Other considerations.

If you need to make a line-break, **always** use a `<br>` element.
**Never** use blank spaces at the end of a line to indicate a manual break.

Two asterisks are used for **important content**, while one asterisk is used for *emphasis*.
Use underscores if you need __boldfaced__ or _italicized_ text without these semantics.

References to code should use `backticks`.
HTML elements should be lowercase and surrounded by angle brackets, like `<this>`; React elements should be capitalized like `<This>` but otherwise rendered in a similar manner.
You may optionally specify attributes as well; `<div class="so">` refers to `<div>` elements with the class `so`.
Functions and constructors should be followed by parentheses, like `this()`.
However, when referring to instances and prototypes, no parentheses are used; for example, one might say `something` is an instance of `ThisOne` even though it was created using the constructor `ThisOne()`.

###  CoffeeScript:

####  Variable naming.

Variables and functions are named using `camelCase`, with the first letter lowercase.
Functions which are meant to serve as constructors, objects which act as modules, and React elements are named using `CamelCase`, with the first letter capitalized.
Enumerals and other constants are named using `UPPERCASE_LETTERS_WITH_UNDERSCORES`.

The Mastodon API frequently makes use of `lowercase_letters_with_underscores` for its parameter names, although we shouldn't have to deal with this directly (as we will be using Laboratory for our event interfacing).

####  Spacing.

Lines should be indented using 4 spaces.
This is very important as it keeps code readable even when it is broken up by long paragraphs of text documentation.

####  Strings.

Strings are double-quoted where possible.
Generally speaking, try to avoid performing substitutions in stings using the `"#{}"` syntax; instead concatenate multiple strings with your code using `+`.

####  Functions.

Generally speaking, if you can avoid using parentheses when calling a function, do.
Include parentheses only if the code becomes very ambiguous to readers otherwise.

####  Objects.

Only wrap an object in `{}` if you are declaring it all on one line; using the multi-line YAML-like syntax is greatly preffered.
This includes in function calls—you don't need parentheses around the object either in this case.

####  Constructors.

Constructors should be written as functions with separate prototypes.
**Do not use CoffeeScript's `class` syntax to write constructors.**
Constructors and their prototypes should always be frozen using `Object.freeze` to prevent them from being modified after creation.

####  Local variables and closure.

Because our CoffeeScript files are concatenated into a single file before compilation, local variables from one file are also available in another.
In general, **you should not use local variables**, and whenever you need to declare a variable outside of the scope of a function you should encapsulate it in a `do ->` statement.

####  Postfix forms.

Generally speaking, you should use the postfix forms of `if`, `unless`, `for`, `while`, etc. where possible.

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

                    Version 0.1.0

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
        彁 'div', (if props.id? then {id: props.id, className: "laboratory-column"} else {className: "laboratory-column"}),
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
        彁 'h2', {className: "laboratory-heading"},
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
>           id=React.PropTypes.number.isRequired
>           href=React.PropTypes.string
>           author=React.PropTypes.object
>           inReplyTo=React.PropTypes.number
>           content=React.PropTypes.string
>           datetime=React.PropTypes.string
>           isReblogged=React.PropTypes.bool
>           isFavourited=React.PropTypes.bool
>           isNSFW=React.PropTypes.bool
>           message=React.PropTypes.string
>           visibility=React.PropTypes.string
>           mediaAttachments=React.PropTypes.array
>           mentions=React.PropTypes.array
>           follower=React.PropTypes.object
>       />
>   ```
>   Creates a `Status` component, which contains a post or a notification. The accepted properties are:
>   -   **`id` [REQUIRED `number`] :**
>       The id of the status.
>   -   **`href` [OPTIONAL `string`] :**
>       A URL at which the status may be viewed.
>   -   **`author` [REQUIRED `object`] :**
>       The account which posted the status.
>   -   **`inReplyTo` [OPTIONAL `number`] :**
>       The id of the status this status is replying to.
>   -   **`content` [REQUIRED `string`] :**
>       The content of the status.
>   -   **`datetime` [REQUIRED `string`] :**
>       The time the status was created.
>   -   **`isReblogged` [OPTIONAL `boolean`] :**
>       Whether or not the user has reblogged this status.
>   -   **`isFavourited` [OPTIONAL `boolean`] :**
>       Whether or not the user has favourited this status.
>   -   **`isNSFW` [OPTIONAL `boolean`] :**
>       Whether or not this status contains sensitive media.
>   -   **`message` [OPTIONAL `string`] :**
>       Spoiler text to display over the status.
>   -   **`visibility` [OPTIONAL `string`] :**
>       The visibility of the status.
>   -   **`mediaAttachments` [OPTIONAL `array`] :**
>       An array of media attachments.
>   -   **`mentions` [OPTIONAL `array`] :**
>       An array of mentions.
>   -   **`rebloggedBy` [OPTIONAL `object`] :**
>       The account which reblogged this status.
>   -   **`favouritedBy` [OPTIONAL `object`] :**
>       The account which favourited this status.
>   -   **`follower` [OPTIONAL `object`] :**
>       The account which initiated a follow.

##  The Component  ##

The `Status` component is a fairly involved React component, which loads an `<article>` containing the status and allowing the user to interact with it.

    Columns.Status = React.createClass

        mixins: [ReactPureRenderMixin]

        propTypes:
            id: React.PropTypes.number.isRequired
            href: React.PropTypes.string
            author: React.PropTypes.object
            inReplyTo: React.PropTypes.number
            content: React.PropTypes.string.isRequired
            datetime: React.PropTypes.string
            isReblogged: React.PropTypes.bool
            isFavourited: React.PropTypes.bool
            isNSFW: React.PropTypes.bool
            message: React.PropTypes.string
            visibility: React.PropTypes.string
            mediaAttachments: React.PropTypes.array
            mentions: React.PropTypes.array
            rebloggedBy: React.PropTypes.object
            favouritedBy: React.PropTypes.object
            follower: React.PropTypes.object

Our function `getListOfMentions()` gets the list of people mentioned in the post, although this is only shown if the post is a reply.
We follow the Chicago convention of using "et al." if there are more than three accounts.

        getListOfMentions: -> switch @props.mentions.length
            when 0 then []
            when 1 then [
                彁 ReactRouter.Link, {to: "/user/" + @props.mentions[0].id},
                    彁 "code", {className: "laboratory-username"}, @props.mentions[0].username
            ]
            when 2 then [
                彁 ReactRouter.Link, {to: "/user/" + @props.mentions[0].id},
                    彁 "code", {className: "laboratory-username"}, @props.mentions[0].username
                彁 ReactIntl.FormattedMessage,
                    id: "status.and"
                    message: " and "
                彁 ReactRouter.Link, {to: "/user/" + @props.mentions[1].id},
                    彁 "code", {className: "laboratory-username"}, @props.mentions[1].username
            ]
            when 3 then [
                彁 ReactRouter.Link, {to: "/user/" + @props.mentions[0].id},
                    彁 "code", {className: "laboratory-username"}, @props.mentions[0].username
                ", "
                彁 ReactRouter.Link, {to: "/user/" + @props.mentions[1].id},
                    彁 "code", {className: "laboratory-username"}, @props.mentions[1].username
                ", "
                彁 ReactIntl.FormattedMessage,
                    id: "status.and"
                    message: " and "
                彁 ReactRouter.Link, {to: "/user/" + @props.mentions[2].id},
                    彁 "code", {className: "laboratory-username"}, @props.mentions[2].username
            ]
            else [
                彁 ReactRouter.Link, {to: "/user/" + @props.mentions[0].id},
                    彁 "code", {className: "laboratory-username"}, @props.mentions[0].username
                彁 ReactIntl.FormattedMessage,
                    id: "status.etal"
                    message: " et al."
            ]

        render: ->
            if @props.follower
                彁 "article", {className: "laboratory-status"},
                    彁 Shared.IDCard,
                        account: @props.follower
                    彁 ReactIntl.FormattedMessage,
                        id: "status.followedyou"
                        message: " followed you!"
            else
                彁 "article", {className: "laboratory-status" + (if @props.isFavourited then " laboratory-status--highlighted" else "")},
                    if @props.rebloggedBy? or @props.favouritedBy? or @props.inReplyTo? then 彁 "aside", null,
                        (switch
                            when @props.inReplyTo? and @props.rebloggedBy? then [
                                彁 ReactRouter.Link, {to: "/user/" + @props.rebloggedBy.id},
                                    彁 "code", {className: "laboratory-username"}, @props.rebloggedBy.username
                                (if @props.mentions?.length then [
                                    彁 ReactIntl.FormattedMessage,
                                        id: "status.boostedthisreplyto"
                                        message: " boosted this reply to "
                                    @getListOfMentions()...
                                ]
                                else [
                                    彁 ReactIntl.FormattedMessage,
                                        id: "status.boostedthisreply"
                                        message: " boosted this reply"
                                ])...
                            ]
                            when @props.inReplyTo? and @props.favouritedBy? then [
                                彁 ReactRouter.Link, {to: "/user/" + @props.favouritedBy.id},
                                    彁 "code", {className: "laboratory-username"}, @props.favouritedBy.username
                                (if @props.mentions?.length then [
                                    彁 ReactIntl.FormattedMessage,
                                        id: "status.highlightedthisreplyto"
                                        message: " highlighted this reply to "
                                    @getListOfMentions()...
                                ]
                                else [
                                    彁 ReactIntl.FormattedMessage,
                                        id: "status.highlightedthisreply"
                                        message: " highlighted this reply"
                                ])...
                            ]
                            when @props.rebloggedBy? then [
                                彁 ReactRouter.Link, {to: "/user/" + @props.rebloggedBy.id},
                                    彁 "code", {className: "laboratory-username"}, @props.rebloggedBy.username
                                彁 ReactIntl.FormattedMessage,
                                    id: "status.boostedthispost"
                                    message: " boosted this post"
                            ]
                            when @props.favouritedBy? then [
                                彁 ReactRouter.Link, {to: "/user/" + @props.favouritedBy.id},
                                    彁 "code", {className: "laboratory-username"}, @props.favouritedBy.username
                                彁 ReactIntl.FormattedMessage,
                                    id: "status.highlightedthispost"
                                    message: " highlighted this post"
                            ]
                            when @props.inReplyTo?
                                if @props.mentions?.length then [
                                    彁 ReactIntl.FormattedMessage,
                                        id: "status.inreplyto"
                                        message: "In reply to "
                                    @getListOfMentions()...
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
                        彁 ReactIntl.FormattedRelative, {value: Date.parse(@props.datetime)},
                            (formattedDate) => 彁 "time", {dateTime: @props.datetime, title: @props.datetime}, formattedDate
                    彁 "div",
                        className: "laboratory-statusContent"
                        dangerouslySetInnerHTML:
                            __html: @props.content
                    彁 "footer", null,
                        彁 Shared.Button,
                            className: "laboratory-button--minimal"
                            containerClass: "laboratory-replybutton"
                            icon: "reply"
                            label: 彁 ReactIntl.FormattedMessage,
                                id: "status.reply"
                                defaultMessage: "Reply"
                        if @props.isFavourited
                            彁 Shared.Button,
                                className: "laboratory-button--minimal"
                                containerClass: "laboratory-unhighlightbutton"
                                icon: "eraser"
                                label: 彁 ReactIntl.FormattedMessage,
                                    id: "status.unhighlight"
                                    defaultMessage: "Unhighlight"
                        else
                            彁 Shared.Button,
                                className: "laboratory-button--minimal"
                                containerClass: "laboratory-highlightbutton"
                                icon: "pencil"
                                label: 彁 ReactIntl.FormattedMessage,
                                    id: "status.highlight"
                                    defaultMessage: "Highlight"
                        if @props.isReblogged
                            彁 Shared.Button,
                                className: "laboratory-button--minimal"
                                containerClass: "laboratory-unboostbutton"
                                icon: "minus-square"
                                label: 彁 ReactIntl.FormattedMessage,
                                    id: "status.unboost"
                                    defaultMessage: "Unboost"
                        else if @props.visibility isnt "private"
                            彁 Shared.Button,
                                className: "laboratory-button--minimal"
                                containerClass: "laboratory-boostbutton"
                                icon: "plus-square"
                                label: 彁 ReactIntl.FormattedMessage,
                                    id: "status.boost"
                                    defaultMessage: "Boost"
                        else
                            彁 Shared.Button,
                                className: "laboratory-button--minimal"
                                containerClass: "laboratory-noboostbutton"
                                icon: "square-o"
                                disabled: true
                                label: 彁 ReactIntl.FormattedMessage,
                                    id: "status.noboost"
                                    defaultMessage: "Private"


#  `Columns.Empty`  #

##  Usage  ##

>   ```jsx
>       <Empty />
>   ```
>   Creates an empty `Column`.

##  The Component  ##

The `Empty` component is just a simple functional React component, which loads an empty `Column`.

    Columns.Empty = -> 彁 Columns.Column, {id: "laboratory-empty"}, 彁 Columns.Heading


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
        彁 Columns.Column, {id: "laboratory-go"},
            彁 Columns.Heading, {icon: "arrow-right"},
                彁 ReactIntl.FormattedMessage,
                    id: "go.heading"
                    defaultMessage: "let's GO!"
            彁 "nav", {className: "laboratory-columnnav"},
                彁 Columns.GoLink, {to: "/user/" + props.myID, icon: "list-alt"},
                    彁 ReactIntl.FormattedMessage,
                        id: 'go.profile'
                        defaultMessage: "Profile"
                彁 Columns.GoLink, {to: "/community", icon: "users"},
                    彁 ReactIntl.FormattedMessage,
                        id: 'go.community'
                        defaultMessage: "Community"
                彁 Columns.GoLink, {to: "/global", icon: "link"},
                    彁 ReactIntl.FormattedMessage,
                        id: 'go.global'
                        defaultMessage: "Global"
            彁 "footer", {className: "laboratory-columnfooter"},
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
        彁 Columns.Column, {id: "laboratory-notfound"},
            彁 Columns.Heading, {icon: "exclamation-triangle"},
                彁 ReactIntl.FormattedMessage,
                    id: 'notfound.not_found'
                    defaultMessage: "Not found"
            彁 ReactIntl.FormattedMessage,
                id: 'notfound.not_found'
                defaultMessage: "Not found"


#  `Columns.Notifications`  #

##  Usage  ##

>   ```jsx
>       <Notifications />
>   ```
>   Creates a `Notifications` component, which contains a column of notifications.

##  The Component  ##

Our `Notifications` component doesn't take any properties, as it is only used for displaying notifications.

    Columns.Notifications = React.createClass

        mixins: [ReactPureRenderMixin]

        getInitialState: ->
            posts: {}
            postOrder: []

###  Handling the event callback:

When we receive a response from Laboratory, we have to handle it with respect to our state.

        handleResponse: (timeline) -> @setState timeline

###  Loading:

When our component first loads, we should request its data.

        componentWillMount: ->
            Laboratory.Timeline.Requested.dispatch
                name: "notifications"
                callback: @handleResponse

###  Unloading:

When our component unloads, we should signal that we no longer need its data.

        componentWillUnmount: ->
            Laboratory.Timeline.Removed.dispatch
                name: "notifications"
                callback: @handleResponse

###  Rendering:

        render: ->
            彁 Columns.Column, {id: "laboratory-notifications"},
                彁 Columns.Heading, {icon: "star-half-o"},
                    彁 ReactIntl.FormattedMessage,
                        id: "notifications.notifications"
                        defaultMessage: "Notifications"
                彁 "div", {className: "laboratory-posts"},
                    (彁 Columns.Status, @state.posts[id] for id in @state.postOrder)...


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
            posts: {}
            postOrder: []

###  Handling the event callback:

When we receive a response from Laboratory, we have to handle it with respect to our state.

        handleResponse: (timeline) -> @setState timeline

###  Getting the heading icon:

The heading icon can be derived from `name` using the following function:

        getIcon: -> switch
            when @props.name is "home" then "home"
            when @props.name is "community" then "users"
            when @props.name is "global" then "link"
            when @props.name.substr(0, 8) is "hashtag/" then "hashtag"
            when @props.name.substr(0, 5) is "user/" then "at"
            else "question-circle"

###  Property change:

If our `name` property changes then we need to request the new data.
Essentially we remove our old request and send a new one.

        componentWillReceiveProps: (nextProps) ->
            return unless @props.name isnt nextProps.name
            Laboratory.Timeline.Removed.dispatch
                name: @props.name
                callback: @handleResponse
            Laboratory.Timeline.Requested.dispatch
                name: nextProps.name
                callback: @handleResponse

###  Loading:

When our timeline first loads, we should request its data.

        componentWillMount: ->
            Laboratory.Timeline.Requested.dispatch
                name: @props.name
                callback: @handleResponse

###  Unloading:

When our timeline unloads, we should signal that we no longer need its data.

        componentWillUnmount: ->
            Laboratory.Timeline.Removed.dispatch
                name: @props.name
                callback: @handleResponse

###  Rendering:

        render: ->
            彁 Columns.Column, null,
                彁 Columns.Heading, {icon: @getIcon()},
                    彁 ReactIntl.FormattedMessage,
                        id: "timeline." + @props.name
                        defaultMessage: @props.name.charAt(0).toLocaleUpperCase() + @props.name.slice(1)
                彁 "div", {className: "laboratory-posts"},
                    (彁 Columns.Status, @state.posts[id] for id in @state.postOrder)...


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
            @close()

###  Closing:

The `close()` function sets our `shouldClose` state property and then does a redirect away from the current page.
If there is somewhere to `closeTo`, then it redirects the user there; if not, it attemps to navigate back and if that fails instead redirects home.
We do this on a `.5s` timeout to give our closing animation time to run.

        close: ->
            @setState {shouldClose: true}
            window.setTimeout (=> if @props.closeTo or window.history?.length <= 1 then @context.router.push(@props.closeTo or "/") else @context.router.goBack()), 500

###  Rendering:

The `render()` function displays our module: just a `<div>` curtain behind our `<main>` element, with children stuck inside.

        render: ->
            彁 "div", (if @state.shouldClose then {id: "laboratory-module", "data-laboratory-dismiss": ""} else {id: "laboratory-module"}),
                彁 "div", {id: "laboratory-curtain", onClick: @close}
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

        handleResponse: (account) -> @setState {account}

###  Property change:

If our `id` property changes then we need to request the new data.
Essentially we remove our old request and send a new one.

        componentWillReceiveProps: (nextProps) ->
            return unless @props.id isnt nextProps.id
            Laboratory.Account.Removed.dispatch
                id: @props.id
                callback: @handleResponse
            Laboratory.Account.Requested.dispatch
                id: nextProps.id
                callback: @handleResponse

###  Loading:

When our account first loads, we should request its data.

        componentWillMount: ->
            Laboratory.Account.Requested.dispatch
                id: @props.id
                callback: @handleResponse

###  Unloading:

When our account unloads, we should signal that we no longer need its data.

        componentWillUnmount: ->
            Laboratory.Account.Removed.dispatch
                id: @props.id
                callback: @handleResponse

###  Rendering:

Our account state is managed by our handlers.
We can check to see if they have succeeded in retreiving our data by comparing the `id` of our properties to the `account.id` of our state.
If these aren't the same, then our request hasn't yet gone through.
However, we will only prevent rendering if our state `account` is `null`—that is, if no request has gone through.
Otherwise, we will let the old data stay until our new information is loaded.

        render: ->
            return null unless @state.account?
            彁 Modules.Module, {attributes: {id: "laboratory-account"}},
                彁 "header", {style: {backgroundImage: "url(#{@state.account.header})"}},
                    彁 "a", {src: @state.account.header, target: "_blank"}
                彁 Shared.IDCard, {account: @state.account, externalLinks: true}
                switch
                    when @state.account.relationship & Laboratory.Relationship.SELF then null
                    when @state.account.relationship & Laboratory.Relationship.FOLLOWING
                        彁 Shared.Button,
                            label: 彁 ReactIntl.FormattedMessage,
                                id: "account.unfollow"
                                defaultMessage: "Unfollow"
                            icon: "user-times"
                    when @state.account.relationship & Laboratory.Relationship.BLOCKING
                        彁 Shared.Button,
                            label: 彁 ReactIntl.FormattedMessage,
                                id: "account.blocked"
                                defaultMessage: "Blocked"
                            icon: "ban"
                            disabled: true
                    when @state.account.relationship & Laboratory.Relationship.REQUESTED
                        彁 Shared.Button,
                            label: 彁 ReactIntl.FormattedMessage,
                                id: "account.requestsent"
                                defaultMessage: "Request Sent"
                            icon: "share-square"
                            disabled: true
                    else
                        if @state.account.locked
                            彁 Shared.Button,
                                label: 彁 ReactIntl.FormattedMessage,
                                    id: "account.requestfollow"
                                    defaultMessage: "Request Follow"
                                icon: "user-secret"
                        else
                            彁 Shared.Button,
                                label: 彁 ReactIntl.FormattedMessage,
                                    id: "account.follow"
                                    defaultMessage: "Follow"
                                icon: "user-plus"
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

##  The Component  ##

The `Composer` class creates our post composition module, which is a surprisingly complex task.

    Modules.Composer = React.createClass

        mixins: [ReactPureRenderMixin]

        propTypes:
            maxChars: React.PropTypes.number.isRequired
            myID: React.PropTypes.number.isRequired
            defaultPrivacy: React.PropTypes.string
            visible: React.PropTypes.bool

###  Our state:

Here you can see our initial state variables—we have quite a lot of them, as this component manages the extensive compose form.
You will note that `text` is initialized to `\n`—in order to function properly, a line break must always be the last thing it produces.

        getInitialState: ->
            account: null
            text: "\n"
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

        handleResponse: (account) -> @setState {account}

###  Loading:

When our compose module first loads, we should request the account data for the currently signed-in user.

        componentWillMount: ->
            Laboratory.Account.Requested.dispatch
                id: @props.myID
                callback: @handleResponse

###  Unloading:

When our compose module unloads, we should signal that we no longer need its data.

        componentWillUnmount: ->
            Laboratory.Account.Removed.dispatch
                id: @props.myID
                callback: @handleResponse

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

###  Resets `shouldClose`:

The `shouldClose` state variable is used to register the fact that a post has been sent, and the composer module should now close.
However, we don't want this variable to *keep* signalling this fact if we then open the composer a second time.
If our `visible` property switches from `false` to `true` then we reset `shouldClose` before proceeding.

        componentWillReceiveProps: (nextProps) ->
            @setState {shouldClose: false} if not @props.visible and nextProps.visible

###  Finding out how many characters are left:

This code quickly replaces all surrogate pairs with a single underscore to achieve an accurate character count.

        getCharsLeft: -> @charsLeft = @props.maxChars - (@input.textbox.value + @input.message.value).replace(/[\uD800-\uDBFF][\uDC00-\uDFFF]/g, "_").length + 1

###  Formatting our text:

This code is used to generate the HTML content of our textbox.
We do this by creating text nodes inside a `<div>` in order to keep our text properly encapsulated and safe.
We then return the `innerHTML` of the result.

We use `<br>`s to represent line-breaks because these have the best browser support.
Again, in order for everything to function smoothly we need to ensure that the last node in this result is a `<br>` element.

        format: (text) ->
            result = document.createElement("div")
            lines = text.split("\n")
            for i in [0..lines.length-1]
                result.appendChild(document.createTextNode(lines[i])) if lines[i]
                result.appendChild(document.createElement("br")) if i isnt lines.length - 1 or lines[i]
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
                            charsLeft: @getCharsLeft()
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
                    if event.target is @input.post and @getCharsLeft() >= 0
                        Laboratory.Composer.Post.dispatch
                            text: @text
                            message: if @state.useMessage then @state.message else null
                            makePublic: @state.makePublic
                            makeListed: @state.makeListed
                            makeNSFW: @state.makeNSFW
                        @setState
                            text: ""
                            message: ""
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
            return null unless @props.visible
            彁 Modules.Module, {attributes: {id: "laboratory-composer"}, close: @state.shouldClose},
                彁 "header", null,
                    if @state.account then 彁 Shared.IDCard, {account: @state.account} else null
                彁 Shared.Textbox,
                    id: "laboratory-composertextbox"
                    "aria-label": @context.intl.messages["composer.placeholder"]
                    onChange: ((text) => @setState {text, charsLeft: @getCharsLeft()})
                    value: @format(@state.text)
                    ref: ((ref) => @input.textbox = ref)
                彁 "footer", null,
                    彁 "span", {id: "laboratory-count"}, if isNaN(@state.charsLeft) then "" else @state.charsLeft
                    彁 Shared.Button,
                        onClick: @handleEvent
                        getRef: ((ref) => @input.post = ref)
                        disabled: @state.charsLeft < 0
                        icon: "paper-plane-o"
                        label: 彁 ReactIntl.FormattedMessage,
                            id: "composer.post"
                            defaultMessage: "Post"
                彁 "aside", {id: "laboratory-composeroptions"},
                    彁 "div", {id: "laboratory-postoptions"},
                        彁 Shared.Toggle,
                            getRef: (ref) => @input.makePublic = ref
                            checked: @state.makePublic
                            onChange: @handleEvent
                            inactiveText: 彁 ReactIntl.FormattedMessage,
                                id: "composer.private"
                                defaultMessage: "Private"
                            inactiveIcon: "microphone-slash"
                            activeIcon: "rss"
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
                            inactiveIcon: "envelope-o"
                            activeIcon: "newspaper-o"
                            activeText: 彁 ReactIntl.FormattedMessage,
                                id: "composer.listed"
                                defaultMessage: "Listed"
                        彁 Shared.Toggle,
                            getRef: (ref) => @input.makeNSFW = ref
                            checked: @state.makeNSFW
                            onChange: @handleEvent
                            disabled: @state.forceNSFW
                            inactiveText: 彁 ReactIntl.FormattedMessage,
                                id: "composer.safe"
                                defaultMessage: "Safe"
                            inactiveIcon: "picture-o"
                            activeIcon: "exclamation"
                            activeText: 彁 ReactIntl.FormattedMessage,
                                id: "composer.sensitive"
                                defaultMessage: "Sensitive"
                    彁 "div", {id: "laboratory-hideoptions"},
                        彁 Shared.Toggle,
                            getRef: (ref) => @input.useMessage = ref
                            checked: @state.useMessage
                            onChange: @handleEvent
                            inactiveText: ""
                            inactiveIcon: "ellipsis-h"
                            activeIcon: "question-circle-o"
                            activeText: 彁 ReactIntl.FormattedMessage,
                                id: "composer.hidewithmessage"
                                defaultMessage: "Hide behind message"
                        彁 "input",
                            type: "text"
                            placeholder: "…… ……"
                            value: @state.message
                            ref: (ref) => @input.message = ref
                            onChange: @handleEvent






#  SHARED  #

##  Implementation  ##

    Shared = {}


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

        componentDidMount: -> @props.getRef(@button) if @props.getRef

        render: ->
            output_props =
                className: "laboratory-button"
                ref: (ref) => @button = ref
            for own key, val of @props
                if key is "className" then output_props[key] += " " + val
                else if ["getRef", "ref", "label", "icon", "containerClass"].indexOf(key) is -1 then output_props[key] = val
            彁 "label", {className: "laboratory-buttoncontainer" + (if @props.containerClass then " " + @props.containerClass else "") + (if @props.disabled then " laboratory-buttoncontainer--disabled" else "")},
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
>   Creates an `Icon` component, which provides a fontawesome icon.

##  The Component  ##

The `Icon` is just a simple functional React component.

    Shared.Icon = (props) ->
        彁 'i',
            className: "fa fa-fw fa-" + props.name
            "aria-hidden": true

    Shared.Icon.propTypes =
        name: React.PropTypes.string.isRequired


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
        彁 'div', {className: "laboratory-idcard"},
            彁 'a', {href: props.account.avatar, target: "_blank"},
                彁 'img', {className: "laboratory-avatar", src: props.account.avatar, alt: props.account.displayName}
            彁 (if props.externalLinks then ["a", {href: props.account.href, title: props.account.displayName, target: "_blank"}] else [ReactRouter.Link, {to: "user/" + props.account.id, title: props.account.displayName}])...,
                彁 'b', {className: "laboratory-displayname"}, props.account.displayName
                彁 'code', {className: "laboratory-username"}, props.account.localAccount

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
            @props.getRef(@input) if @props.getRef?
            @value = @getContents()

        caret: 0
        value: "\n"

###  Event handling:

For the most part, we just call `getContents()` to update our `value` whenever something happens to our textbox.
However, if the user types "enter" then we need to ensure that the result is just a simple `<br>` line feed and not some weird `<div>`-induced magic that browsers like Chrome like to pull.

        handleEvent: (event) ->
            return unless (event.type is "input" or event.type is "blur" or event.type is "keypress") and event.target is @input
            if event.type is "keypress"
                if event.key is "Enter" or event.code is "Enter" or event.keyCode is 0x0D
                    event.preventDefault()
                    sel = window.getSelection()
                    rng = sel.getRangeAt 0
                    rng.deleteContents()
                    rng.insertNode(br = document.createElement "br")
                    rng.setEndAfter br
                    rng.collapse false
                    sel.removeAllRanges()
                    sel.addRange rng
                else return
            @value = @getContents()
            @props.onChange(@value) if @props.onChange

###  Retrieving textbox contents:

This is a little more complicated than it should be since we have to account for `<br>`s.
We walk the tree of our textbox and collect the content of every text node, but also insert a `"\n"` for each `<br>` we find.
So, this is a `<br>`-aware `Element.textContent`.

        getContents: ->
            wkr = document.createTreeWalker @input
            nde = null
            out = ""
            while wkr.nextNode()?
                nde = wkr.currentNode
                if nde.nodeType is Node.TEXT_NODE then out += nde.textContent
                else if nde.nodeType is Node.ELEMENT_NODE and nde.tagName.toUpperCase() is "BR" then out += "\n"
            out += "\n" if out.length and out.slice(-1) isnt "\n"
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

            sel = window.getSelection()
            rng = sel.getRangeAt 0

`pre` is a range consisting of everything leading up to the end of `rng`.
First we select our entire text area, and then we set the endpoint of the range to be the endpoint of our current selection.

            pre = rng.cloneRange()
            pre.selectNodeContents @input
            pre.setEnd rng.endContainer, rng.endOffset

This next line tells us how many line breaks were in the selected range.
This is a somewhat expensive operation as it involves cloning DOM nodes, but there isn't any faster way.

            brs = pre.cloneContents().querySelectorAll("br").length

We can now find the length of the selection by adding the text content to the number of line breaks.

            @caret = pre.toString().length + brs
            pre.detach()
            return

###  Mangaing caret position before and after updating:

We use `componentWillUpdate` to grab the caret position right before updating, and `componentDidUpdate` to set it right after.

        componentWillUpdate: -> @updateCaretPos()

We're going to use a `TreeWalker` to walk the contents of our textbox until we find the correct position to stick our caret.

        componentDidUpdate: ->
            sel = window.getSelection()
            rng = document.createRange()
            wkr = document.createTreeWalker @input
            idx = 0
            nde = null
            success = false

If our caret is as long as our `value`, we can cut straight to the chase and stick our caret at the end.

            success = true if @caret >= @value.length - 1

This loop breaks when either we run out of nodes, or we find the text node that our caret belongs in.
It will also break if we wind up in-between two `<br>`s, as that is a possibility.

            loop
                break unless wkr.nextNode()?
                nde = wkr.currentNode
                if nde.nodeType is Node.TEXT_NODE
                    if idx <= @caret <= idx + nde.textContent.length
                        success = true
                        break
                    else idx += nde.textContent.length
                else if nde.nodeType is Node.ELEMENT_NODE and nde.tagName.toUpperCase() is "BR"
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
            sel.removeAllRanges()
            sel.addRange rng

###  Rendering

For all its complexity, `Textbox` is just a single `<div>`.
We set it's contents through `dangerouslySetInnerHTML`, which would normally be slower than just sticking them in directly (through `node.appendChild`) except that we're already dealing with `innerHTML`s when we call `shouldComponentUpdate()`, above.

        render: ->
            output_props =
                className: "laboratory-textbox" + (if @props.value.toLowerCase() is "<br>" or @props.value is "\n" or @props.value is "" then " laboratory-textbox--empty" else "") + (if @props.className? then " " + @props.className else "")
                contentEditable: true
                onKeyPress: @handleEvent
                onInput: @handleEvent
                onBlur: @handleEvent
                ref: (ref) => @input = ref
                dangerouslySetInnerHTML:
                    __html: @props.value
            output_props[key] = value for own key, value of @props when ["className", "contentEditable", "value", "getRef", "onChange", "onInput", "onBlur", "dangerouslySetInnerHTML", "ref"].indexOf(key) is -1
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
            activeIcon: "check-circle-o"
            inactiveIcon: "times"

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
                        event.preventDefault()
                        @input.focus()
                        @input.click()
                    @setState {checked: @input.checked}
                when "onFocus"
                    @setState {hasFocus: true}
                    @props.onFocus event if @props.onFocus
                when "onBlur"
                    @setState {hasFocus: false}
                    @props.onBlur event if @props.onBlur

        render: ->
            output_props = {className: "laboratory-toggle-screenreader-only", type: "checkbox", onFocus: @handleEvent, onBlur: @handleEvent, ref: (ref) => @input = ref}
            output_props[key] = value for own key, value of @props when ["className", "activeText", "activeIcon", "inactiveText", "inactiveIcon", "getRef", "ref", "type", "onFocus", "onBlur"].indexOf(key) is -1
            彁 "label", {className: "laboratory-toggle" + (if @state.checked then " laboratory-toggle--checked" else "") + (if @state.disabled then " laboratory-toggle--disabled" else "") + (if @state.hasFocus then " laboratory-toggle--focus" else "") + (if @props.className then " " + @props.className else ""), onClick: @handleEvent},
                彁 "span", {className: "laboratory-toggle-label laboratory-toggle-label-off"}, @props.inactiveText
                彁 "div", {className: "laboratory-toggle-track"},
                    彁 "div", {className: "laboratory-toggle-track-check"},
                        彁 Shared.Icon, {name: @props.activeIcon}
                    彁 "div", {className: "laboratory-toggle-track-x"},
                        彁 Shared.Icon, {name: @props.inactiveIcon}
                    彁 "div", {className: "laboratory-toggle-thumb"}
                    彁 "input", output_props
                彁 "span", {className: "laboratory-toggle-label laboratory-toggle-label-on"}, @props.activeText


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
                Laboratory.Authorization.Requested.dispatch
                    url: "https://" + @input.value
                    redirect: @props.basename
                    name: @props.title
                @setState {value: ""}
            return

###  Rendering:

        render: ->

…And here's what we render:

            return 彁 ReactIntl.IntlProvider, {locale: @props.locale, messages: Locales[@props.locale]},
                彁 "div", {id: "laboratory-instancequery"},
                    彁 ReactIntl.FormattedMessage,
                        id: "instancequery.queryinstance"
                        defaultMessage: "What's your instance?"
                    彁 "div", {id: "laboratory-instancequeryinput"},
                        彁 "code", {className: "laboratory-username"}, "username@"
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

            @history = (if @props.useBrowserHistory then ReactRouter.useRouterHistory(History.createHistory) else ReactRouter.useRouterHistory(History.createHashHistory))({basename: @props.basename})

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
        彁 'header', {id: "laboratory-header"},
            彁 UI.Title, null,
                props.title
            彁 ReactRouter.Link, {to: "/compose"},
                彁 Shared.Button,
                    icon: "pencil-square-o"
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

###  Event handling:

Here we will handle events related to the UI:

        handleEvent: (e) ->
            switch e.type

####  Drag-and-drop.

This handles our drag-and-drop events:

                when "dragenter" then document.getElementById("laboratory-ui").setAttribute "data-laboratory-dragging", ""
                when "dragover"
                    e.preventDefault()
                    e.dataTransfer.dropEffect = "copy"
                when "dragleave" then document.getElementById("laboratory-ui").removeAttribute "data-laboratory-dragging" unless e.relatedTarget?
                when "drop"
                    e.preventDefault()
                    document.getElementById("laboratory-ui").removeAttribute "data-laboratory-dragging"
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
            彁 'div', {id: "laboratory-ui"},
                彁 UI.Header, {title: @props.title}
                彁 Columns.Timeline, {name: "home"}
                彁 Columns.Notifications
                @props.thirdColumn
                @props.children
                彁 Modules.Composer,
                    defaultPrivacy: @props.defaultPrivacy
                    myID: @props.myID
                    maxChars: @props.maxChars
                    visible: @props.showComposer


#  LOCALES  #

##  Implementation  ##

    Locales = {}


    Locales.de = Object.freeze

        "timeline.home": "Home"
        "notifications.notifications": "Mitteilungen"
        "composer.compose": "Schreiben"
        "notfound.not_found": "Nicht gefunden"
        # "go.heading":
        # "go.community":
        # "go.global":

        #  Unused codes from Mastodon:

        "column_back_button.label": "Zurück"
        "lightbox.close": "Schließen"
        "loading_indicator.label": "Lade..."
        "status.mention": "Erwähnen"
        "status.delete": "Löschen"
        "status.reply": "Antworten"
        "status.reblog": "Teilen"
        "status.favourite": "Favorisieren"
        "status.reblogged_by": "{name} teilte"
        "status.sensitive_warning": "Sensible Inhalte"
        "status.sensitive_toggle": "Klicken um zu zeigen"
        "status.open": "Öffnen"
        "video_player.toggle_sound": "Ton umschalten"
        "account.mention": "Erwähnen"
        "account.edit_profile": "Profil bearbeiten"
        "account.unblock": "Entblocken"
        "account.unfollow": "Entfolgen"
        "account.block": "Blocken"
        "account.follow": "Folgen"
        "account.posts": "Beiträge"
        "account.follows": "Folgt"
        "account.followers": "Folger"
        "account.follows_you": "Folgt dir"
        "account.requested": "Warte auf Erlaubnis"
        "getting_started.heading": "Erste Schritte"
        "getting_started.about_addressing": "Du kannst Leuten folgen falls du ihren Nutzernamen und ihre Domain kennst in dem du eine e-mail-artige Addresse in das Suchfeld oben an der Seite eingibst."
        "getting_started.about_shortcuts": "Falls der Zielnutzer an derselben Domain ist wie du funktioniert der Nutzername auch alleine. Das gilt auch für Erwähnungen in Beiträgen."
        "getting_started.about_developer": "Der Entwickler des Projekts kann unter Gargron@mastodon.social gefunden werden"
        "getting_started.open_source_notice": "Mastodon ist quelloffene Software. Du kannst auf {github} dazu beitragen oder Probleme melden."
        "column.home": "Home"
        "column.mentions": "Erwähnungen"
        "column.public": "Gesamtes Bekanntes Netz"
        "column.notifications": "Mitteilungen"
        "column.follow_requests": "Folgeanfragen"
        "tabs_bar.compose": "Schreiben"
        "tabs_bar.home": "Home"
        "tabs_bar.mentions": "Erwähnungen"
        "tabs_bar.public": "Gesamtes Netz"
        "tabs_bar.notifications": "Mitteilungen"
        "compose_form.placeholder": "Worüber möchstest du schreiben?"
        "compose_form.publish": "Veröffentlichen"
        "compose_form.sensitive": "Medien als sensitiv markieren"
        "compose_form.unlisted": "Öffentlich nicht auflisten"
        "compose_form.private": "Als privat markieren"
        "navigation_bar.edit_profile": "Profil bearbeiten"
        "navigation_bar.preferences": "Einstellungen"
        "navigation_bar.public_timeline": "Öffentlich"
        "navigation_bar.logout": "Abmelden"
        "navigation_bar.follow_requests": "Folgeanfragen"
        "reply_indicator.cancel": "Abbrechen"
        "search.placeholder": "Suche"
        "search.account": "Konto"
        "search.hashtag": "Hashtag"
        "upload_button.label": "Media-Datei anfügen"
        "upload_form.undo": "Entfernen"
        "notification.follow": "{name} folgt dir"
        "notification.favourite": "{name} favorisierte deinen Status"
        "notification.reblog": "{name} teilte deinen Status"
        "notification.mention": "{name} erwähnte dich"
        "notifications.column_settings.alert": "Desktop-Benachrichtigunen"
        "notifications.column_settings.show": "In der Spalte anzeigen"
        "notifications.column_settings.follow": "Neue Folger:"
        "notifications.column_settings.favourite": "Favorisierungen:"
        "notifications.column_settings.mention": "Erwähnungen:"
        "notifications.column_settings.reblog": "Geteilte Beiträge:"
        "follow_request.authorize": "Erlauben"
        "follow_request.reject": "Ablehnen"
        "home.column_settings.basic": "Einfach"
        "home.column_settings.advanced": "Fortgeschritten"
        "home.column_settings.show_reblogs": "Geteilte Beiträge anzeigen"
        "home.column_settings.show_replies": "Antworten anzeigen"
        "home.column_settings.filter_regex": "Filter durch reguläre Ausdrücke"
        "missing_indicator.label": "Nicht gefunden"


    Locales.en = Object.freeze

        "timeline.home": "Home"
        "notifications.notifications": "Notifications"

        "composer.compose": "Compose"
        "composer.post": "Post"
        "composer.private": "Private"
        "composer.public": "Public"
        "composer.unlisted": "Unlisted"
        "composer.listed": "Listed"
        "composer.safe": "Safe"
        "composer.sensitive": "Sensitive"
        "composer.hidewithmessage": "Hide behind message"
        "composer.placeholder": "What's going on?"

        "account.follow": "Follow"
        "account.unfollow": "Unfollow"
        "account.blocking": "Blocking"
        "account.requestfollow": "Request Follow"
        "account.requestsent": "Request Sent"
        "account.statuses": "Posts"
        "account.following": "Follows"
        "account.followers": "Followers"

        "status.and": " and "
        "status.etal": " et al."
        "status.followedyou": " followed you!"
        "status.boostedthisreplyto": " boosted this reply to "
        "status.boostedthisreply": " boosted this reply"
        "status.boostedthispost": " boosted this post"
        "status.highlightedthisreplyto": " highlighted this reply to "
        "status.highlightedthisreply": " highlighted this reply"
        "status.highlightedthispost": " highlighted this post"
        "status.inreplyto": "In reply to "
        "status.inreplytoself": "In reply to themselves"

        "go.heading": "let's GO!"
        "go.community": "Community"
        "go.global": "Global"

        "toggle.off": "Off"
        "toggle.on": "On"

        "notfound.not_found": "Not found"

        #  Unused codes from Mastodon:

        "column_back_button.label": "Back"
        "lightbox.close": "Close"
        "loading_indicator.label": "Loading..."
        "status.mention": "Mention"
        "status.delete": "Delete"
        "status.reply": "Reply"
        "status.reblog": "Boost"
        "status.favourite": "Favourite"
        "status.reblogged_by": "{name} boosted"
        "status.sensitive_warning": "Sensitive content"
        "status.sensitive_toggle": "Click to view"
        "video_player.toggle_sound": "Toggle sound"
        "account.mention": "Mention"
        "account.edit_profile": "Edit profile"
        "account.unblock": "Unblock"
        "account.unfollow": "Unfollow"
        "account.block": "Block"
        "account.follow": "Follow"
        "account.posts": "Posts"
        "account.follows": "Follows"
        "account.followers": "Followers"
        "account.follows_you": "Follows you"
        "account.requested": "Awaiting approval"
        "getting_started.heading": "Getting started"
        "getting_started.about_addressing": "You can follow people if you know their username and the domain they are on by entering an e-mail-esque address into the search form."
        "getting_started.about_shortcuts": "If the target user is on the same domain as you just the username will work. The same rule applies to mentioning people in statuses."
        "getting_started.about_developer": "The developer of this project can be followed as Gargron@mastodon.social"
        "getting_started.open_source_notice": "Mastodon is open source software. You can contribute or report issues on github at {github}."
        "column.home": "Home"
        "column.mentions": "Mentions"
        "column.public": "Public"
        "column.notifications": "Notifications"
        "tabs_bar.compose": "Compose"
        "tabs_bar.home": "Home"
        "tabs_bar.mentions": "Mentions"
        "tabs_bar.public": "Public"
        "tabs_bar.notifications": "Notifications"
        "compose_form.placeholder": "What is on your mind?"
        "compose_form.publish": "Toot"
        "compose_form.sensitive": "Mark media as sensitive"
        "compose_form.spoiler": "Hide text behind warning"
        "compose_form.private": "Mark as private"
        "compose_form.privacy_disclaimer": "Your private status will be delivered to mentioned users on {domains}. Do you trust {domainsCount plural one {that server} other {those servers}} to not leak your status?"
        "compose_form.unlisted": "Do not display in public timeline"
        "navigation_bar.edit_profile": "Edit profile"
        "navigation_bar.preferences": "Preferences"
        "navigation_bar.public_timeline": "Public timeline"
        "navigation_bar.logout": "Logout"
        "reply_indicator.cancel": "Cancel"
        "search.placeholder": "Search"
        "search.account": "Account"
        "search.hashtag": "Hashtag"
        "upload_button.label": "Add media"
        "upload_form.undo": "Undo"
        "notification.follow": "{name} followed you"
        "notification.favourite": "{name} favourited your status"
        "notification.reblog": "{name} boosted your status"
        "notification.mention": "{name} mentioned you"
        "notifications.column_settings.alert": "Desktop notifications"
        "notifications.column_settings.show": "Show in column"
        "notifications.column_settings.follow": "New followers:"
        "notifications.column_settings.favourite": "Favourites:"
        "notifications.column_settings.mention": "Mentions:"
        "notifications.column_settings.reblog": "Boosts:"
        "missing_indicator.label": "Not found"


    Locales.es = Object.freeze

        "timeline.home": "Inicio"
        "notifications.notifications": "Notificaciones"
        "composer.compose": "Redactar"
        "notfound.not_found": "No encontrada"
        # "go.heading":
        # "go.community":
        # "go.global":

        #  Unused codes from Mastodon:

        "column_back_button.label": "Atrás"
        "lightbox.close": "Cerrar"
        "loading_indicator.label": "Cargando..."
        "status.mention": "Mencionar"
        "status.delete": "Borrar"
        "status.reply": "Responder"
        "status.reblog": "Republicar"
        "status.favourite": "Favorito"
        "status.reblogged_by": "{name} republicado"
        "video_player.toggle_sound": "Act/Desac. sonido"
        "account.mention": "Mención"
        "account.edit_profile": "Editar perfil"
        "account.unblock": "Desbloquear"
        "account.unfollow": "Dejar de seguir"
        "account.block": "Bloquear"
        "account.follow": "Seguir"
        "account.block": "Bloquear"
        "account.posts": "Publicaciones"
        "account.follows": "Seguir"
        "account.followers": "Seguidores"
        "account.follows_you": "Te sigue"
        "getting_started.heading": "Primeros pasos"
        "getting_started.about_addressing": "Puedes seguir a gente si conoces su nombre de usuario y el dominio en el que están registrados introduciendo algo similar a una dirección de correo electrónico en el formulario en la parte superior de la barra lateral."
        "getting_started.about_shortcuts": "Si el usuario que buscas está en el mismo dominio que tú simplemente funcionará introduciendo el nombre de usuario. La misma regla se aplica para mencionar a usuarios."
        "getting_started.about_developer": "Puedes seguir al desarrollador de este proyecto en Gargron@mastodon.social"
        "column.home": "Inicio"
        "column.mentions": "Menciones"
        "column.public": "Historia pública"
        "column.notifications": "Notificaciones"
        "tabs_bar.compose": "Redactar"
        "tabs_bar.home": "Inicio"
        "tabs_bar.mentions": "Menciones"
        "tabs_bar.public": "Público"
        "tabs_bar.notifications": "Notificaciones"
        "compose_form.placeholder": "¿En qué estás pensando?"
        "compose_form.publish": "Publicar"
        "compose_form.sensitive": "Marcar el contenido como sensible"
        "compose_form.unlisted": "Privado"
        "navigation_bar.edit_profile": "Editar perfil"
        "navigation_bar.preferences": "Preferencias"
        "navigation_bar.public_timeline": "Público"
        "navigation_bar.logout": "Cerrar sesión"
        "reply_indicator.cancel": "Cancelar"
        "search.placeholder": "Buscar"
        "search.account": "Cuenta"
        "search.hashtag": "Etiqueta"
        "upload_button.label": "Añadir medio"
        "upload_form.undo": "Deshacer"
        "notification.follow": "{name} le esta ahora siguiendo"
        "notification.favourite": "{name} marcó como favorito su estado"
        "notification.reblog": "{name} volvió a publicar su estado"
        "notification.mention": "Fue mencionado por {name}"


    Locales.fr = Object.freeze

        "timeline.home": "Accueil"
        "notifications.notifications": "Notifications"
        "composer.compose": "Composer"
        "notfound.not_found": "Pas trouvé"
        # "go.heading":
        # "go.community":
        # "go.global":

        #  Unused codes from Mastodon:

        "column_back_button.label": "Retour"
        "lightbox.close": "Fermer"
        "loading_indicator.label": "Chargement…"
        "status.mention": "Mentionner"
        "status.delete": "Effacer"
        "status.reply": "Répondre"
        "status.reblog": "Partager"
        "status.favourite": "Ajouter aux favoris"
        "status.reblogged_by": "{name} a partagé :"
        "status.sensitive_warning": "Contenu délicat"
        "status.sensitive_toggle": "Cliquer pour dévoiler"
        "video_player.toggle_sound": "Mettre/Couper le son"
        "account.mention": "Mentionner"
        "account.edit_profile": "Modifier le profil"
        "account.unblock": "Débloquer"
        "account.unfollow": "Ne plus suivre"
        "account.block": "Bloquer"
        "account.follow": "Suivre"
        "account.posts": "Statuts"
        "account.follows": "Abonnements"
        "account.followers": "Abonnés"
        "account.follows_you": "Vous suit"
        "getting_started.heading": "Pour commencer"
        "getting_started.about_addressing": "Vous pouvez vous suivre les statuts de quelqu’un en entrant dans le champs de recherche leur identifiant et le domaine de leur instance séparés par un @ à la manière d’une adresse courriel."
        "getting_started.about_shortcuts": "Si cette personne utilise la même instance que vous l’identifiant suffit. C’est le même principe pour mentionner quelqu’un dans vos statuts."
        "getting_started.about_developer": "Pour suivre le développeur de ce projet c’est Gargron@mastodon.social"
        "column.home": "Accueil"
        "column.mentions": "Mentions"
        "column.public": "Fil public"
        "column.notifications": "Notifications"
        "tabs_bar.compose": "Composer"
        "tabs_bar.home": "Accueil"
        "tabs_bar.mentions": "Mentions"
        "tabs_bar.public": "Public"
        "tabs_bar.notifications": "Notifications"
        "compose_form.placeholder": "Qu’avez-vous en tête ?"
        "compose_form.publish": "Pouet"
        "compose_form.sensitive": "Marquer le contenu comme délicat"
        "compose_form.unlisted": "Ne pas apparaître dans le fil public"
        "navigation_bar.edit_profile": "Modifier le profil"
        "navigation_bar.preferences": "Préférences"
        "navigation_bar.public_timeline": "Public"
        "navigation_bar.logout": "Déconnexion"
        "reply_indicator.cancel": "Annuler"
        "search.placeholder": "Chercher"
        "search.account": "Compte"
        "search.hashtag": "Mot-clé"
        "upload_button.label": "Joindre un média"
        "upload_form.undo": "Annuler"
        "notification.follow": "{name} vous suit."
        "notification.favourite": "{name} a ajouté à ses favoris :"
        "notification.reblog": "{name} a partagé votre statut :"
        "notification.mention": "{name} vous a mentionné⋅e :"


    Locales.hu = Object.freeze

        "timeline.home": "Kezdőlap"
        "notifications.notifications": "Értesítések"
        "composer.compose": "Összeállítás"
        "notfound.not_found": "Nem található"
        # "go.heading":
        # "go.community":
        # "go.global":

        #  Unused codes from Mastodon:

        "column_back_button.label": "Vissza"
        "lightbox.close": "Bezárás"
        "loading_indicator.label": "Betöltés..."
        "status.mention": "Említés"
        "status.delete": "Törlés"
        "status.reply": "Válasz"
        "status.reblog": "Reblog"
        "status.favourite": "Kedvenc"
        "status.reblogged_by": "{name} reblogolta"
        "status.sensitive_warning": "Érzékeny tartalom"
        "status.sensitive_toggle": "Katt a megtekintéshez"
        "video_player.toggle_sound": "Hang kapcsolása"
        "account.mention": "Említés"
        "account.edit_profile": "Profil szerkesztése"
        "account.unblock": "Blokkolás levétele"
        "account.unfollow": "Követés abbahagyása"
        "account.block": "Blokkolás"
        "account.follow": "Követés"
        "account.posts": "Posts"
        "account.follows": "Követők"
        "account.followers": "Követők"
        "account.follows_you": "Követnek téged"
        "getting_started.heading": "Első lépések"
        "getting_started.about_addressing": "Követhetsz embereket felhasználónevük és a doménjük ismeretében amennyiben megadod ezt az e-mail-szerű címet az oldalsáv tetején lévő rubrikában."
        "getting_started.about_shortcuts": "Ha a célzott személy azonos doménen tartózkodik a felhasználónév elegendő. Ugyanez érvényes mikor személyeket említesz az állapotokban."
        "getting_started.about_developer": "A projekt fejlesztője követhető mint Gargron@mastodon.social"
        "column.home": "Kezdőlap"
        "column.mentions": "Említések"
        "column.public": "Nyilvános"
        "column.notifications": "Értesítések"
        "tabs_bar.compose": "Összeállítás"
        "tabs_bar.home": "Kezdőlap"
        "tabs_bar.mentions": "Említések"
        "tabs_bar.public": "Nyilvános"
        "tabs_bar.notifications": "Notifications"
        "compose_form.placeholder": "Mire gondolsz?"
        "compose_form.publish": "Tülk!"
        "compose_form.sensitive": "Tartalom érzékenynek jelölése"
        "compose_form.unlisted": "Listázatlan mód"
        "navigation_bar.edit_profile": "Profil szerkesztése"
        "navigation_bar.preferences": "Beállítások"
        "navigation_bar.public_timeline": "Nyilvános időfolyam"
        "navigation_bar.logout": "Kijelentkezés"
        "reply_indicator.cancel": "Mégsem"
        "search.placeholder": "Keresés"
        "search.account": "Fiók"
        "search.hashtag": "Hashtag"
        "upload_button.label": "Média hozzáadása"
        "upload_form.undo": "Mégsem"
        "notification.follow": "{name} követ téged"
        "notification.favourite": "{name} kedvencnek jelölte az állapotod"
        "notification.reblog": "{name} reblogolta az állapotod"
        "notification.mention": "{name} megemlített"


    Locales.pt = Object.freeze

        "timeline.home": "Home"
        "notifications.notifications": "Notificações"
        "composer.compose": "Compôr"
        "notfound.not_found": "Não encontrada"
        # "go.heading":
        # "go.community":
        # "go.global":

        #  Unused codes from Mastodon:

        "column_back_button.label": "Voltar"
        "lightbox.close": "Fechar"
        "loading_indicator.label": "Carregando..."
        "status.mention": "Menção"
        "status.delete": "Deletar"
        "status.reply": "Responder"
        "status.reblog": "Reblogar"
        "status.favourite": "Favoritar"
        "status.reblogged_by": "{name} reblogou"
        "video_player.toggle_sound": "Alterar som"
        "account.mention": "Menção"
        "account.edit_profile": "Editar perfil"
        "account.unblock": "Desbloquear"
        "account.unfollow": "Unfollow"
        "account.block": "Bloquear"
        "account.follow": "Seguir"
        "account.block": "Bloquear"
        "account.posts": "Posts"
        "account.follows": "Segue"
        "account.followers": "Seguidores"
        "account.follows_you": "Segue você"
        "getting_started.heading": "Primeiros passos"
        "getting_started.about_addressing": "Podes seguir pessoas se sabes o nome de usuário deles e o domínio em que estão entrando um endereço similar a e-mail no campo no topo da barra lateral."
        "getting_started.about_shortcuts": "Se o usuário alvo está no mesmo domínio só o nome funcionará. A mesma regra se aplica a mencionar pessoas nas postagens."
        "getting_started.about_developer": "O desenvolvedor desse projeto pode ser seguido em Gargron@mastodon.social"
        "column.home": "Home"
        "column.mentions": "Menções"
        "column.public": "Público"
        "tabs_bar.compose": "Compôr"
        "tabs_bar.home": "Home"
        "tabs_bar.mentions": "Menções"
        "tabs_bar.public": "Público"
        "tabs_bar.notifications": "Notificações"
        "compose_form.placeholder": "Que estás pensando?"
        "compose_form.publish": "Publicar"
        "compose_form.sensitive": "Marcar conteúdo como sensível"
        "compose_form.unlisted": "Modo não-listado"
        "navigation_bar.edit_profile": "Editar perfil"
        "navigation_bar.preferences": "Preferências"
        "navigation_bar.public_timeline": "Timeline Pública"
        "navigation_bar.logout": "Logout"
        "reply_indicator.cancel": "Cancelar"
        "search.placeholder": "Busca"
        "search.account": "Conta"
        "search.hashtag": "Hashtag"
        "upload_button.label": "Adicionar media"
        "upload_form.undo": "Desfazer"
        "notification.follow": "{name} seguiu você"
        "notification.favourite": "{name} favoritou  seu post"
        "notification.reblog": "{name} reblogou o seu post"
        "notification.mention": "{name} mecionou você"


    Locales.uk = Object.freeze

        "timeline.home": "Головна"
        "notifications.notifications": "Сповіщення"
        "composer.compose": "Написати"
        "notfound.not_found": "Не знайдено"
        # "go.heading":
        # "go.community":
        # "go.global":

        #  Unused codes from Mastodon:

        "column_back_button.label": "Назад"
        "lightbox.close": "Закрити"
        "loading_indicator.label": "Завантаження..."
        "status.mention": "Згадати"
        "status.delete": "Видалити"
        "status.reply": "Відповісти"
        "status.reblog": "Передмухнути"
        "status.favourite": "Подобається"
        "status.reblogged_by": "{name} передмухнув(-ла)"
        "status.sensitive_warning": "Непристойний зміст"
        "status.sensitive_toggle": "Натисніть щоб подивитися"
        "video_player.toggle_sound": "Увімкнути/вимкнути звук"
        "account.mention": "Згадати"
        "account.edit_profile": "Налаштування профілю"
        "account.unblock": "Розблокувати"
        "account.unfollow": "Відписатися"
        "account.block": "Заблокувати"
        "account.follow": "Підписатися"
        "account.posts": "Пости"
        "account.follows": "Підписки"
        "account.followers": "Підписники"
        "account.follows_you": "Підписаний"
        "getting_started.heading": "Ласкаво просимо"
        "getting_started.about_addressing": "Ви можете підписуватись на людей якщо ви знаєте їх ім'я користувача чи домен шляхом введення email-подібної адреси у верхньому рядку бокової панелі."
        "getting_started.about_shortcuts": "Якщо користувач якого ви шукаєте знаходиться на тому ж домені що й ви можна просто ввести ім'я користувача. Це правило стосується й згадування людей у статусах."
        "getting_started.about_developer": "Розробник проекту знаходиться за адресою Gargron@mastodon.social"
        "column.home": "Головна"
        "column.mentions": "Згадування"
        "column.public": "Стіна"
        "column.notifications": "Сповіщення"
        "tabs_bar.compose": "Написати"
        "tabs_bar.home": "Головна"
        "tabs_bar.mentions": "Згадування"
        "tabs_bar.public": "Стіна"
        "tabs_bar.notifications": "Сповіщення"
        "compose_form.placeholder": "Що у Вас на думці?"
        "compose_form.publish": "Дмухнути"
        "compose_form.sensitive": "Непристойний зміст"
        "compose_form.unlisted": "Таємний режим"
        "navigation_bar.edit_profile": "Редагувати профіль"
        "navigation_bar.preferences": "Налаштування"
        "navigation_bar.public_timeline": "Публічна стіна"
        "navigation_bar.logout": "Вийти"
        "reply_indicator.cancel": "Відмінити"
        "search.placeholder": "Пошук"
        "search.account": "Аккаунт"
        "search.hashtag": "Хештеґ"
        "upload_button.label": "Додати медіа"
        "upload_form.undo": "Відмінити"
        "notification.follow": "{name} підписався(-лась) на Вас"
        "notification.favourite": "{name} сподобався ваш допис"
        "notification.reblog": "{name} передмухнув(-ла) Ваш статус"
        "notification.mention": "{name} згадав(-ла) Вас"


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
The first, recommended method is by including a JSON configuration object in the `data-labcoat-config` attribute on the root element.
The second method is by including a script which provides configuration details to `window.INITIAL_STATE`.
**Use of `window.INITIAL_STATE` is strongly discouraged for "unhosted" installs and is only supported to minimize the amount of configuration necessary for installations on a Mastodon server.**

The configuration options supported by Labcoat are as follows:

###  General configuration:

| Property | INITIAL_STATE equivalent | Description |
| -------- | ------------------------ | :---------- |
| `title` | `meta.title` | The title for the frontend. If you are hosting this on a Mastodon server, you might want to set this to the name of the server. Otherwise, it will default to "Labcoat" |
| `display` | *Not available* | Display modes (see below). |
| `basename` | `meta.router_basename` | The base pathname for the frontend. For example, a Labcoat frontend hosted at `http://example.org/gateway` would use the basename `/gateway`. This defaults to `/web` for compatibility reasons. |
| `useBrowserHistory` | `meta.use_history` | Use a more modern browser history instead of a hash-based history. For compatibility reasons, this defaults to `true`, so be sure to set this to `false` if your server isn't properly configured to handle it. |
| `locale` | `meta.locale` | The locale for the frontend. |
| `root` | `meta.react_root` | The id of the root element to draw the frontend into. Will default to `frontend`, if available, or the `<body>` element, if not. |
| `defaultPrivacy` | `compose.default_privacy` | The initial privacy setting to use for posts. This will default to `"unlisted"` if it isn't set. |

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

##  Implementation  ##

This script loads and runs the Labcoat frontend.
Consequently, it is the last thing we load.

###  First steps:

We include informative text about the `Labcoat` package on `Labcoat.ℹ` and give the version number on `Labcoat.Nº` for intersted parties.
Labcoat follows semantic versioning, which translates into `Nº` as follows: `Major * 100 + Minor + Patch / 100`.
Labcoat thus assures that minor and patch numbers will never exceed `99` (indeed this would be quite excessive!).

    Object.defineProperty window, "Labcoat",
        value: Object.freeze
            ℹ: """

                ............... LABCOAT ................

                 A client-side frontend for Mastodon, a
                free & open-source social network server
                           - - by Kibigo! - -

                    Licensed under the MIT License.
                       Source code available at:
                  https://github.com/marrus-sh/labcoat

                            Version 0.1.0

                """
            Nº: 1.0
        enumerable: yes

###  Handling locale data:

This adds locale data so that our router can handle it:

    ReactIntl.addLocaleData [ReactIntlLocaleData.en..., ReactIntlLocaleData.de..., ReactIntlLocaleData.es..., ReactIntlLocaleData.fr..., ReactIntlLocaleData.pt..., ReactIntlLocaleData.hu..., ReactIntlLocaleData.uk...]

###  Configuration:

The `config` object will store our configuration properties.
This won't be transparent to the `window`.
If `data-labcoat-config` is set on the root element, we can go ahead and pull our configuration from there.

    config = if document.documentElement.hasAttribute "data-labcoat-config" then JSON.parse document.documentElement.getAttribute "data-labcoat-config" else {}

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
            when (elt = document.getElementsByClassName("app-body").item 0) then elt
            else document.body

####  Rendering into the root.

There are two different root elements that Labcoat might render.
The first, if we aren't in single-user mode, is a simple form for getting the origin from which to send the signin request.
The second is the frontend itself.

If we're running in single-user mode, we need to give Laboratory our authorization information.
Basically, we just spoof a server response.

        if config.accessToken then Laboratory.Initialization.Received.dispatch
            data:
                access_token: config.accessToken

Otherwise, we can go ahead and load our instance query now.

        else ReactDOM.render 彁(Shared.InstanceQuery, {
            title: config.title
            locale: config.locale
            basename: config.basename
        }), config.root

Finally, we add an event listener for `LaboratoryAccountReceived`.
We're not actually interested in the data for this event, but it signals that our authorization worked and that the current user has been found.
Our callback for this event will load our *actual* frontend into our react root.

        callback = ->
            ReactDOM.unmountComponentAtNode config.root
            ReactDOM.render 彁(Shared.Frontend, {
                title: config.title
                locale: config.locale
                myID: Laboratory.user
                useBrowserHistory: config.useBrowserHistory
                basename: config.basename
                defaultPrivacy: config.defaultPrivacy
            }), config.root
            document.removeEventListener "LaboratoryAccountReceived", callback

        document.addEventListener "LaboratoryAccountReceived", callback

###  Running asynchronously:

We need to wait for Laboratory before we can load our frontend.

    if Laboratory?.ready then run() else document.addEventListener "LaboratoryInitializationReady", run
