#  `Columns.Go`  #

##  Usage  ##

>   ```jsx
>       <Go
>           myID=React.PropTypes.number.isRequired
>           footerLinks=React.PropTypes.object
>       />
>   ```
>   Creates a `Column` component which contains a menu of useful tasks. The accepted properties are:
>   -   **`myID` [OPTIONAL `number`] :**
>       The id of the currently signed-in user.
>   -   **`footerLinks` [OPTIONAL `object`] :**
>       An object whose enumerable own properties provide links to display in the footer.

##  The Component  ##

The `Go` component is just a simple functional React component, which loads a `Column` with helpful links.

    Columns.Go = (props) ->
        彁 Columns.Column, {id: "labcoat-go"},
            彁 Columns.Heading, {icon: "icon.go"},
                彁 ReactIntl.FormattedMessage,
                    id: "go.heading"
                    defaultMessage: "let's GO!"
            彁 "nav", {className: "labcoat-columnnav"},
                彁 Columns.GoLink, {to: "/user/" + props.myID, icon: "icon.profile"},
                    彁 ReactIntl.FormattedMessage,
                        id: 'go.profile'
                        defaultMessage: "Profile"
                彁 Columns.GoLink, {to: "/community", icon: "icon.community"},
                    彁 ReactIntl.FormattedMessage,
                        id: 'go.community'
                        defaultMessage: "Community"
                彁 Columns.GoLink, {to: "/global", icon: "icon.global"},
                    彁 ReactIntl.FormattedMessage,
                        id: 'go.global'
                        defaultMessage: "Global"
            彁 "footer", {className: "labcoat-columnfooter"},
                彁 "nav", null,
                    (彁 "a", {href: value, target: "_self"}, key for key, value of (if props.footerLinks? then props.footerLinks else {}))...

    Columns.Go.propTypes =
        footerLinks: React.PropTypes.object
        myID: React.PropTypes.number.isRequired
