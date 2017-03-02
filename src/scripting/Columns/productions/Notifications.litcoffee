#  `Columns.Notifications`  #

##  Usage  ##

>   ```jsx
>       <Notifications />
>   ```
>   Creates a `Notifications` component, which contains a column of notifications.

##  The Component  ##

Our `Notifications` component doesn't take any properties, as it is only used for displaying notifications.

    Columns.Notifications = React.createClass

        mixins: [PureRenderMixin]

        getInitialState: ->
            items: {}
            itemOrder: []
            settings: {}

###  Loading:

When our component first loads, we should request its data.

        componentWillMount: ->
            Events.Notifications.Requested.dispatch
                component: this

###  Unloading:

When our component unloads, we should signal that we no longer need its data.

        componentWillUnmount: ->
            Events.Notifications.Removed.dispatch
                component: this

###  Rendering:

        render: ->
            彁 Columns.Column, {id: "laboratory-notifications"},
                彁 Columns.Heading, {icon: "star-half-o"},
                    彁 ReactIntl.FormattedMessage,
                        id: "notifications.notifications"
                        defaultMessage: "Notifications"
                彁 "div", {className: "laboratory-posts"},
                    (彁 Columns.Status, @state.items[id] for id in @state.itemOrder)...
