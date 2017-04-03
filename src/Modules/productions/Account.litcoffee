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
            
        request: null

###  Handling the event callback:

When we receive a response from Laboratory, we have to handle it with respect to our state.

        handleResponse: (event) -> @setState {account: event.detail.response}

###  Property change:

If our `id` property changes then we need to request the new data.
Essentially we remove our old request and send a new one.

        componentWillReceiveProps: (nextProps) ->
            return unless @props.id isnt nextProps.id
            do @request.stop
            @request.removeEventListener "response", @handleResponse
            @request = new Laboratory.Profile.Request {id: nextProps.id}
            @request.addEventListener "response", @handleResponse
            do @request.start

###  Loading:

When our account first loads, we should request its data.

        componentWillMount: ->
            @request = new Laboratory.Profile.Request {id: @props.id}
            @request.addEventListener "response", @handleResponse
            do @request.start

###  Unloading:

When our account unloads, we should signal that we no longer need its data.

        componentWillUnmount: ->
            do @request.stop
            @request.removeEventListener "response", @handleResponse

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
