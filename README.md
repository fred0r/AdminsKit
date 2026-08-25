# AdminsKit

AdminsKit is a native C++ **AMX Mod X module** for Counter-Strike 1.6 (GoldSrc) servers running ReHLDS, ReGameDLL, and Metamod. It packages 5 admin utility plugins into a single shared library.

## Plugins

| Plugin | Description |
|---|---|
| **Admin Free Look** | Lets admins spectate players on the opposing team, bypassing `mp_forcecamera` |
| **Invisible Spectator** | Hides admins from the scoreboard while spectating |
| **Unlimited Choose Team** | Removes the "one team switch per round" restriction |
| **Server Stats** | Real-time FPS / CPU / RAM HUD overlay for admins |
| **WH Detection Helper** | Admin ESP — see enemies through walls with colored boxes, beams, and entity transparency |

## Dependencies

| Dependency | Source |
|---|---|
| CSSDK | https://gitlab.com/goldsrc-sdk/cssdk (GoldSrc SDK, ReHLDS, ReGameDLL headers) |
| Metamod | https://gitlab.com/goldsrc-sdk/metamod |
| AMXX SDK | https://gitlab.com/goldsrc-sdk/amxx |
| Core | https://gitlab.com/goldsrc-sdk/core |
| MHooks | https://gitlab.com/goldsrc-sdk/mhooks |
| Cista | https://github.com/felixguendling/cista |

### API Versions

- **ReHLDS API**: v3.15
- **ReGameDLL API**: v5.30

## Build

Requires CMake 3.21+, Ninja, and a C++17 compiler with 32-bit support.

```bash
./build.sh                                # clang release, 1 job (default)
./build.sh -c=gcc -t=debug                # gcc debug
./build.sh -c=clang -j=4                  # clang release, 4 jobs
./build.sh -c=gcc -t=relwithdebinfo -j=8  # gcc relwithdebinfo, 8 jobs
```

Output: `bin/<compiler>/adminskit_amxx_i386.so` (Linux) or `adminskit_amxx.dll` (Windows).

## Installation

Place the built module in `addons/amxmodx/modules/` on your game server. Config files and language data are in `third_party/addons/`.

## License

GPL v3 — see [LICENSE](LICENSE).
