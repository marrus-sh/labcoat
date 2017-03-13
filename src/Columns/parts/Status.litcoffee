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
