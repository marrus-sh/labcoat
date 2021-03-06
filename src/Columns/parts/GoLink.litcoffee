#  `Columns.GoLink`  #

##  Usage  ##

>   ```jsx
>       <GoLink
>           to=React.PropTypes.string.required
>           icon=React.PropTypes.string.required
>       />
>           {/* content */}
>       </GoLink>
>   ```
>   Creates a `Column` component which contains a menu of useful tasks. The accepted properties are:
>   -   **`to` [REQUIRED `string`] :**
>       Where the link is going to.
>   -   **`icon` [REQUIRED `string`] :**
>       The icon associated with the link.

##  The Component  ##

The `GoLink` component is a simple functional React component which just packages a `Link` with an icon.

    Columns.GoLink = (props) ->
        彁 ReactRouter.Link, {to: props.to, "aria-hidden": true},
            彁 Shared.Icon, {name: props.icon}
            props.children

    Columns.GoLink.propTypes =
        to: React.PropTypes.string.isRequired
        icon: React.PropTypes.string.isRequired
