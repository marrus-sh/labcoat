#  `UI.Header`  #

##  Usage  ##

>   ```jsx
>       <Header
>           title=React.PropTypes.string
>       />
>   ```
>   Creates a `Header` component, which contains various user actions. The accepted properties are:
>   -   **`title` [OPTIONAL `string`] :**
>       The title of the site

##  The Component  ##

The `Header` is just a simple functional React component.

    UI.Header = (props) ->
        彁 'header', {id: "laboratory-header"},
            彁 UI.Title, null,
                props.title
            彁 ReactRouter.Link, {to: "/compose"},
                彁 Shared.Button,
                    icon: "pencil-square-o"
                    label: 彁 ReactIntl.FormattedMessage,
                        id: "composer.compose"
                        defaultMessage: "Compose"

    UI.Header.propTypes =
        title: React.PropTypes.string
