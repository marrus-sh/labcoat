#  `Shared.Icon`  #

##  Usage  ##

>   ```jsx
>       <Icon
>           name=React.PropTypes.string.isRequired
>       />
>   ```
>   Creates an `Icon` component, which provides a fontawesome icon. The accepted properties are:
>   -   **`name` [REQUIRED `string`] :**
>       The message used to acquire the icon.

##  The Component  ##

The `Icon` is just a simple React component.

    Shared.Icon = React.createClass

        mixins: [ReactPureRenderMixin]

        propTypes:
            name: React.PropTypes.string.isRequired

We will need `intl` from the React context in order to access the composer placeholder text.

        contextTypes:
            intl: React.PropTypes.object.isRequired

        render: ->
            彁 'i',
                className: "fa fa-fw fa-" + (@context.intl.messages[@props.name] || @props.name)
                "aria-hidden": true
