# hawks

A lightweight, cherry-pickable bundle of Higher-Order Components (HOCs) for React, in the vein of Recompose.

## Notes

### `/lib` cherry-picking convention

All `hawks` components are cherry-pickable with `import Component from 'hawks/lib/component'`.

### Pure by default

Most components produced by `hawks` are "pure-by-default", which is to say they inherit from `React.PureComponent` and will only render if they receive new props or state.

## Components

### withConstProps
```js
withConstProps(
  propMap: (initialProps) => {
    [constPropName: string]: [value: any]
  },
): HigherOrderComponent
```

Like `withProps`, except the props are created once at component initialization time, and never change throughout the component's lifecycle.

### withPropsFromObservables
```js
withPropsFromObservables(
  propsToObservableMap: (initialProps) => {
    [valuePropName: string]: [observable: Observable]
  },
  shouldUpdate?: (nextProps, currentProps) => boolean
): HigherOrderComponent
```

Given a function mapping props to an observable map, merges corresponding props into the subcomponent's props (as in `withProps`) with the current value of each observable. The observables are watched for changes and the subcomponent is rerendered with new props in realtime.

The `propsToObservableMap` function receives the props of the upstream components and must produce an object of the form `{ propName: Observable, ...}` with each named property receiving the current value of the corresponding observable.

By default, `propsToObservableMap` will be called every time the props change and the resulting observable map will be diffed against the previous one, with observables being (un)subscribed as needed. If the optional `shouldUpdate` function is provided, the `propsToObservableMap` will only be called, and the internal observable state will only be updated, if the `shouldUpdate` returns a truthy value upon receiving new props.

### withRouterLink
```js
withRouterLink(
  eventName: string (default 'onClick'),
  routerAction: string (default: 'push')
): HigherOrderComponent
```

> NB: This component is for use with the `react-router` `withRouter` HOC, which must precede it in the `compose()` chain. This library does not depend on `react-router` nor enforce the presence of the HOC; you must do this yourself.

Creates an event handler on the wrapped component which will cause a `react-router` transition when called. By default, the `onClick` event handler is provided, and the router state is `push`ed when the handler fires. This component will also add an `active` prop to the wrapped component, according as the router's current path matches the path this component links to.

You may pass the standard `react-router` props to the outer component: `to` for URL, `query`, `hash`, and `state` for parameter-passing, and `onlyActiveOnIndex` to mask out route wildcards.
