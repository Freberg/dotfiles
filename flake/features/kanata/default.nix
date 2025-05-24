{ ... }:
{
  services.kanata = {
    enable = true;
    keyboards = {
      internalKeyboard = {
        devices = [
          "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
        ];
        extraDefCfg = "process-unmapped-keys yes";
        config = ''
          (defsrc
            grv 1 2 3 4 5 6 7 8 9 0 - = bspc
            tab q w e r t y u i o p [ ]
            caps a s d f g h j k l ; ' ret
            lsft lsgt z x c v b n m , . / rsft
            lctl lmet lalt spc ralt rctl
          )

          (defvar
            tap-time 200
            hold-time 200

            left-hand-keys (
              q w e r t
              a s d f g
              z x c v b
            )
            right-hand-keys (
              y u i o p
              h j k l ;
              n m , . /
            )
          )

          (deflayer base
            grv 1 2 3 4 5 6 7 8 9 0 - = bspc
            tab q w e r t y u i o p [ ]
            @caps @a @s @d @f g h @j @k @l @; ' ret
            lsft lsgt z x c v b n m , . / rsft
            lctl lmet lalt spc @altgr-symbol-layer @rctl
          )
          (deflayer nomods
            _ _ _ _ _ _ _ _ _ _ _ _ _ _  
            _ _ _ _ _ _ _ _ _ _ _ _ _    
            _ a s d f _ _ j k l ; _ _
            _ _ _ _ _ _ _ _ _ _ _ _ _    
            _ _ _ _ _ _  
          )
          (deflayer symbols 
            RA-grv RA-1 RA-2 RA-3 RA-4 RA-5 RA-6 RA-7 RA-8 RA-9 RA-0 RA-- RA-= RA-bspc  
            _ _ _ _ _ _ _ _ RA-lsgt _ _ _ _    
            @caps RA-2 RA-4 S-8 S-9 S-7 RA-- RA-7 RA-0 RA-8 RA-9 _ _
            _ RA-lsgt _ _ _ _ _ _ _ _ _ _ _    
            _ _ _ _ _ _  
          )

          (deffakekeys
            to-base (layer-switch base)
          )

          (defalias
            tap (multi
              (layer-switch nomods)
              (on-idle-fakekey to-base tap 20)
            )

            caps esc
            rctl bspc
            altgr-symbol-layer (layer-while-held symbols)

            a (tap-hold-release-keys $tap-time $hold-time (multi a @tap) lmet $left-hand-keys)
            s (tap-hold-release-keys $tap-time $hold-time (multi s @tap) lalt $left-hand-keys)
            d (tap-hold-release-keys $tap-time $hold-time (multi d @tap) lsft $left-hand-keys)
            f (tap-hold-release-keys $tap-time $hold-time (multi f @tap) lctl $left-hand-keys)
            j (tap-hold-release-keys $tap-time $hold-time (multi j @tap) rctl $right-hand-keys)
            k (tap-hold-release-keys $tap-time $hold-time (multi k @tap) rsft $right-hand-keys)
            l (tap-hold-release-keys $tap-time $hold-time (multi l @tap) lalt $right-hand-keys)
            ; (tap-hold-release-keys $tap-time $hold-time (multi ; @tap) rmet $right-hand-keys)
          )
        '';
      };
    };
  };
}
