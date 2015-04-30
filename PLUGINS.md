autobuild2 plugins
==================

autobuild2 contains a proof-of-concept level plugin system, which loads specific scripts in packing processes.

NAMING
------

Plugins are named in the following ways:

  * ab processing steps. For example, `base_*` is loaded after the base libraries are ready.
    **Currently defined steps**:
    * base: base library loaded.
    * pkgm: package manager loaded.
      * $ABPM: PM-specific plugins.
    * define, patch, build, override, pack: Steps passed/files loaded.
    * For optional steps like patch, override and beyond, `run_foo` is loaded only if the step `foo` is run.
  * Architecture names. For example, `amd64_x_*` is loaded for the step `x` on arch `amd64`.

HINTS
-----

You can use return in a plugin to exit the plugin.

```Bash
cp --version | grep -q GNU ||
  return # not GNU cp, do nothing.
```

FUNCTIONS
---------

The plugin system uses `_ab_plug()` to load plugins `{,$ARCH_}$PLUGTYPE_*`.


