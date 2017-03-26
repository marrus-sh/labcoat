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
