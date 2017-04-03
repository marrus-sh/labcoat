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

        request: null

###  Handling the event callback:

When we receive a response from Laboratory, we have to handle it with respect to our state.

        handleResponse: (event) -> @setState {timeline: event.detail.response}

###  Getting the timeline parameters:

The timeline parameters can be derived from `name` using the following function:

        getParams: (name = @props.name) -> switch
            when name is "home"
                type: Laboratory.Timeline.Type.HOME
                query: ""
                isLocal: no
            when name is "community"
                type: Laboratory.Timeline.Type.PUBLIC
                query: ""
                isLocal: yes
            when name is "global"
                type: Laboratory.Timeline.Type.PUBLIC
                query: ""
                isLocal: no
            when (name.substr 0, 8) is "hashtag/"
                type: Laboratory.Timeline.Type.HASHTAG
                query: name.substr 8
                isLocal: no
            when (name.substr 0, 5) is "user/"
                type: Laboratory.Timeline.Type.ACCOUNT
                query: name.substr 5
                isLocal: no
            when name is "notifications"
                type: Laboratory.Timeline.Type.NOTIFICATIONS
                query: ""
                isLocal: no
            when name is "highlights"
                type: Laboratory.Timeline.Type.FAVOURITES
                query: ""
                isLocal: no
            else
                type: Laboratory.Timeline.Type.UNDEFINED
                query: ""
                isLocal: no

###  Getting the heading icon:

The heading icon can be derived from `name` using the following function:

        getIcon: -> switch name
            when "home" then "icon.home"
            when "community" then "icon.community"
            when "global" then "icon.global"
            when (name.substr 0, 8) is "hashtag/" then "icon.hashtag"
            when (name.substr 0, 5) is "user/" then "icon.user"
            when "notifications" then "icon.notifications"
            when "highlights" then "icon.favourite"
            else "icon.mystery"

###  Property change:

If our `name` property changes then we need to request the new data.

        componentWillReceiveProps: (nextProps) ->
            return unless @props.name isnt nextProps.name
            do @request.stop
            @request.removeEventListener "response", @handleResponse
            @request = new Laboratory.Timeline.Request @getParams nextProps.name
            @request.addEventListener "response", @handleResponse
            do @request.start

###  Loading:

When our timeline first loads, we should request its data.

        componentWillMount: ->
            @request = new Laboratory.Timeline.Request do @getParams
            @request.addEventListener "response", @handleResponse
            do @request.start

###  Unloading:

When our timeline unloads, we should forget our listener.

        componentWillUnmount: ->
            do @request.stop
            @request.removeEventListener "response", @handleResponse

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
