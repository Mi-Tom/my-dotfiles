#!/bin/bash

# 1. Definice cesty pro uživatelské rozložení
XKB_SYMBOLS_DIR="/usr/share/X11/xkb/symbols"
LAYOUT_FILE="$XKB_SYMBOLS_DIR/us-cz-custom"

echo "Vytvářím konfigurační soubor klávesnice: $LAYOUT_FILE"

# 2. Zápis XKB symbolů (převod z tvého Nix zápisu)
sudo tee $LAYOUT_FILE > /dev/null <<EOF
xkb_symbols "basic" {
    include "us(basic)"
    include "level3(ralt_switch)"

    key <AC01> { [ a,          A,          aacute,          Aacute          ] };
    key <AD03> { [ e,          E,          eacute,          Eacute          ] };
    key <AD08> { [ i,          I,          iacute,          Iacute          ] };
    key <AD09> { [ o,          O,          oacute,          Oacute          ] };
    key <AD07> { [ u,          U,          uacute,          Uacute          ] };
    key <AD06> { [ y,          Y,          yacute,          Yacute          ] };

    key <AC02> { [ s,          S,          scaron,          Scaron          ] };
    key <AB03> { [ c,          C,          ccaron,          Ccaron          ] };
    key <AD04> { [ r,          R,          rcaron,          Rcaron          ] };
    key <AB01> { [ z,          Z,          zcaron,          Zcaron          ] };
    key <AC03> { [ d,          D,          dcaron,          Dcaron          ] };
    key <AD05> { [ t,          T,          tcaron,          Tcaron          ] };
    key <AB06> { [ n,          N,          ncaron,          Ncaron          ] };
    
    key <AD11> { [ bracketleft, braceleft, ecaron,          Ecaron          ] };
    key <AC10> { [ semicolon,   colon,     uring,           Uring           ] };

    key <AE05> { [ 5,           percent,   EuroSign,        EuroSign        ] };
};
EOF

# Nastavení layoutu pro X11 (trvalé přes localectl)
echo "Nastavuji systémové rozložení klávesnice..."
sudo localectl set-x11-keymap us-cz-custom "" "" ""

# Volitelné: Okamžitá aplikace pro aktuální sezení (pokud běží X11)
if [ -n "$DISPLAY" ]; then
    setxkbmap us-cz-custom -option "lv3:ralt_switch"
    echo "Klávesnice byla okamžitě aktivována v X11."
fi

echo "Hotovo. Po restartu nebo znovupřihlášení bude layout aktivní."