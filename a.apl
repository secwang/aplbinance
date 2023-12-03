#!/usr/bin/env dyalogscript

⎕IO ← 0
(⎕NS⍬).(_←enableSALT⊣⎕CY'salt')

display←{ ⎕IO ⎕ML←0 ⋄ ⍺←1 ⋄ chars←⍺⊃'..''''|-' '┌┐└┘│─' ⋄ tl tr bl br vt hz←chars ⋄ box←{ vrt hrz←(¯1+⍴⍵)⍴¨vt hz ⋄ top←(hz,'⊖→')[¯1↑⍺],hrz ⋄ bot←(⊃⍺),hrz ⋄ rgt←tr,vt,vrt,br ⋄ lax←(vt,'⌽↓')[¯1↓1↓⍺],¨⊂vrt ⋄ lft←⍉tl,(↑lax),bl ⋄ lft,(top⍪⍵⍪bot),rgt } ⋄ deco←{⍺←type open ⍵ ⋄ ⍺,axes ⍵} ⋄ axes←{(-2⌈⍴⍴⍵)↑1+×⍴⍵} ⋄ open←{(1⌈⍴⍵)⍴⍵} ⋄ trim←{(~1 1⍷∧⌿⍵=' ')/⍵} ⋄ type←{{(1=⍴⍵)⊃'+'⍵}∪,char¨⍵} ⋄ char←{⍬≡⍴⍵:hz ⋄ (⊃⍵∊'¯',⎕D)⊃'#~'}∘⍕ ⋄ line←{(6≠10|⎕DR' '⍵)⊃' -'}⋄ { 0=≡⍵:' '⍪(open ⎕FMT ⍵)⍪line ⍵ ⋄ 1 ⍬≡(≡⍵)(⍴⍵):'∇' 0 0 box ⎕FMT ⍵ ⋄ 1=≡⍵:(deco ⍵)box open ⎕FMT open ⍵ ⋄ ('∊'deco ⍵)box trim ⎕FMT ∇¨open ⍵ }⍵ }

pp←{⍵⊣⎕←#.display ⍵}
assert←{⍺←'assertion failure' ⋄ 0∊⍵:⍺ ⎕SIGNAL 8 ⋄ shy←0} ⍝ https://www.jsoftware.com/papers/APL_exercises/


st← 'fapi.binance.com' '' '' ⍝ endpoint,api,key

ts←{t ← (20 ⎕DT'Z')×1000 ⋄ t ← 'I13' ⎕fmt t ⋄ t[0;]}  ⍝ ts 0 → unix sec in ms

h ← {((2÷⍨⍴⍵) ,2) ⍴ ⍵}
ue←{x←h ⍵⋄ m← x[;0] ,¨'=',¨⍕¨ x[;1]⋄ ¯1↓ ∊m,¨'&'} ⍝   ue 'abc' 'example' 'def' '123' 'ghi' '5.6'
⍝ a si b

⍝ bg '/fapi/v1/allOrders'  
bg←{ u1←  'https://',(⊃st[0]),⍵⋄ q← 'timestamp=', ts 0  ⋄si←⊃⎕sh './sign.sh ' , q ,' ' , (⊃st[2])⋄ x←  'curl -s -H "X-MBX-APIKEY: ', (⊃st[1]), '" -X GET "', u1,'?' , q ,'&signature=' , si ,'"' ⋄⊃⎕SH x  } 

⍝'symbol=BTCUSDT&side=BUY&type=LIMIT&timeInForce=GTC&quantity=0.02&price=10000' bp '/fapi/v1/order'

bp←{ q ← ⍺  ⋄ u ← 'https://',(⊃st[0]),⍵  ⋄ q1 ←  q ,'&timestamp=', ts 0  ⋄ si← ⊃⎕sh  './sign.sh "' , q1 , '" "' , (⊃st[2]) ,'"' ⋄ x←  'curl -s -H "X-MBX-APIKEY: ', (⊃st[1]) , '" -X POST "', u ,'" -d "' , q1 , '&signature=' , si ,'" '  ⋄ ⎕sh x }


(ue 'symbol' 'BTCUSDT' 'side' 'BUY'  'type' 'LIMIT' 'timeInForce' 'GTC' )

)save -force a.dws

