# lapine-cookbook

TODO: Enter the cookbook description here.

## Supported Platforms

TODO: List your supported platforms.

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['lapine']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

## Usage

### lapine::default

Include `lapine` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[lapine::default]"
  ]
}
```

## License and Authors

Author:: Wanelo, Inc. (<dev@wanelo.com>)
