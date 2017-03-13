#  `Shared.Icon`  #

##  Usage  ##

>   ```jsx
>       <Icon
>           name=React.PropTypes.string.isRequired
>       />
>   ```
>   Creates an `Icon` component, which provides a fontawesome icon.

##  The Component  ##

The `Icon` is just a simple functional React component.

    Shared.Icon = (props) ->
        彁 'i',
            className: "fa fa-fw fa-" + props.name
            "aria-hidden": true

    Shared.Icon.propTypes =
        name: React.PropTypes.string.isRequired
