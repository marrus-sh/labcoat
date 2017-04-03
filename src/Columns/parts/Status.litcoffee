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
                                    action: (
                                        new Laboratory.Post.SetFavourite
                                            id: @props.id
                                            value: off
                                    ).start
                            else
                                彁 Shared.Action,
                                    active: no
                                    className: "labcoat-favourite"
                                    icon: "icon.favourite"
                                    label: 彁 ReactIntl.FormattedMessage,
                                        id: "status.favourite"
                                        defaultMessage: "Highlight"
                                    action: (
                                        new Laboratory.Post.SetFavourite
                                            id: @props.id
                                            value: on
                                    ).start
                            if @props.isReblogged
                                彁 Shared.Action,
                                    active: yes
                                    className: "labcoat-unreblog"
                                    icon: "icon.unreblog"
                                    label: 彁 ReactIntl.FormattedMessage,
                                        id: "status.unreblog"
                                        defaultMessage: "Unboost"
                                    action: (
                                        new Laboratory.Post.SetReblog
                                            id: @props.id
                                            value: off
                                    ).start
                            else if @props.visibility & Laboratory.Post.Visibility.REBLOGGABLE
                                彁 Shared.Action,
                                    active: no
                                    className: "labcoat-reblog"
                                    icon: "icon.reblog"
                                    label: 彁 ReactIntl.FormattedMessage,
                                        id: "status.reblog"
                                        defaultMessage: "Boost"
                                    action: (
                                        new Laboratory.Post.SetReblog
                                            id: @props.id
                                            value: on
                                    ).start
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
