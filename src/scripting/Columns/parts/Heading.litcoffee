#  `Columns.Heading`  #

##  Usage  ##

>   ```jsx
>       <Heading
>           icon=React.PropTypes.string
>       >
>           {/* content */}
>       </Heading>
>   ```
>   Creates a `Heading` component, which is just the heading to a `Column`. The accepted properties are:
>   -   **`icon` [REQUIRED `string`] :**
>       The icon to associate with the heading.

##  The Component  ##

The `Heading` is just a simple functional React component.

    Columns.Heading = (props) ->
        彁 'h2', {className: "laboratory-heading"},
            if props.icon
                彁 Shared.Icon, {name: props.icon}
            else null
            props.children

    Columns.Heading.propTypes =
        icon: React.PropTypes.string
