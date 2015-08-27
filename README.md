## 新增API

```swift
// 下拉更新
let x = self.tableView.frame.origin.x

self.tableView.addHeaderWithCallback({
    // code
}, x: x)
```

```swift
// 上拉获取更多

let x = self.tableView.frame.origin.x
self.tableView.addFooterWithCallback({
    // code
}, x: x)
```

