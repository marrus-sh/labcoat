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
