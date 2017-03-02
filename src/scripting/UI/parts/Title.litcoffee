#  `UI.Title`  #

##  Usage  ##

>   ```jsx
>       <Title>
>           {/* content */}
>       </Title>
>   ```
>   Creates a `Title` component, which links back to the homepage.

##  The Component  ##

The `Title` is just a simple functional React component.

    UI.Title = (props) ->
        彁 'h1', null,
            彁 ReactRouter.Link, {to: "/"},
                props.children
