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
