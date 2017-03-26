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
