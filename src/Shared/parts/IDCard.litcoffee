#  `Shared.IDCard`  #

##  Usage  ##

>   ```jsx
>       <IDCard
>           account=React.PropTypes.object
>           externalLinks=React.PropTypes.bool
>       />
>   ```
>   Creates a `IDCard` component, which contains identification information for a status/post. The accepted properties are:
>   -   **`account` [REQUIRED `object`] :**
>       The account to identify.
>   -   **`externalLinks` [OPTIONAL `boolean`] :**
>       Whether to use internal or external links for the account page.

##  The Component  ##

The `IDCard` is just a simple functional React component.

    Shared.IDCard = (props) ->
        return null unless props.account instanceof Object
        彁 'div', {className: "labcoat-idcard"},
            彁 (if props.externalLinks then ["a", {href: props.account.avatar, target: "_blank"}] else [ReactRouter.Link, {to: "user/" + props.account.id, title: props.account.displayName}])...,
                彁 'img', {className: "labcoat-avatar", src: props.account.avatar, alt: props.account.displayName}
            彁 (if props.externalLinks then ["a", {href: props.account.href, title: props.account.displayName, target: "_blank"}] else [ReactRouter.Link, {to: "user/" + props.account.id, title: props.account.displayName}])...,
                彁 'b', {className: "labcoat-displayname"}, props.account.displayName
                彁 'code', {className: "labcoat-username"}, props.account.localAccount

    Shared.IDCard.propTypes =
        account: React.PropTypes.object.isRequired
        externalLinks: React.PropTypes.bool
