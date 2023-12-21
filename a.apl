#!/usr/bin/env dyalogscript

⎕IO ← 0
(⎕NS⍬).(_←enableSALT⊣⎕CY'salt')

display←{ ⎕IO ⎕ML←0 ⋄ ⍺←1 ⋄ chars←⍺⊃'..''''|-' '┌┐└┘│─' ⋄ tl tr bl br vt hz←chars ⋄ box←{ vrt hrz←(¯1+⍴⍵)⍴¨vt hz ⋄ top←(hz,'⊖→')[¯1↑⍺],hrz ⋄ bot←(⊃⍺),hrz ⋄ rgt←tr,vt,vrt,br ⋄ lax←(vt,'⌽↓')[¯1↓1↓⍺],¨⊂vrt ⋄ lft←⍉tl,(↑lax),bl ⋄ lft,(top⍪⍵⍪bot),rgt } ⋄ deco←{⍺←type open ⍵ ⋄ ⍺,axes ⍵} ⋄ axes←{(-2⌈⍴⍴⍵)↑1+×⍴⍵} ⋄ open←{(1⌈⍴⍵)⍴⍵} ⋄ trim←{(~1 1⍷∧⌿⍵=' ')/⍵} ⋄ type←{{(1=⍴⍵)⊃'+'⍵}∪,char¨⍵} ⋄ char←{⍬≡⍴⍵:hz ⋄ (⊃⍵∊'¯',⎕D)⊃'#~'}∘⍕ ⋄ line←{(6≠10|⎕DR' '⍵)⊃' -'}⋄ { 0=≡⍵:' '⍪(open ⎕FMT ⍵)⍪line ⍵ ⋄ 1 ⍬≡(≡⍵)(⍴⍵):'∇' 0 0 box ⎕FMT ⍵ ⋄ 1=≡⍵:(deco ⍵)box open ⎕FMT open ⍵ ⋄ ('∊'deco ⍵)box trim ⎕FMT ∇¨open ⍵ }⍵ }

pp←{⍵⊣⎕←#.display ⍵}
assert←{⍺←'assertion failure' ⋄ 0∊⍵:⍺ ⎕SIGNAL 8 ⋄ shy←0} ⍝ https://www.jsoftware.com/papers/APL_exercises/


sapi fapi api key ← 'api.binance.com' 'fapi.binance.com' '' '' ⍝ endpoint,api,key

2⎕fix '∇r←ts' 'tst ← (20 ⎕DT''Z'')×1000' 'tst ← ''I13'' ⎕fmt tst' 'r←tst[0;]' '∇'




h ← {((2÷⍨⍴⍵) ,2) ⍴ ⍵}
ue←{x←h ⍵⋄ m← x[;0] ,¨'=',¨⍕¨ x[;1]⋄ ¯1↓ ∊m,¨'&'} ⍝   ue 'abc' 'example' 'def' '123' 'ghi' '5.6'



sbg←{⍺←⍬⋄ u1←  'https://',sapi,⍵⋄ x ← 'curl -s -X GET "' , u1, '"'⋄⍺≡⍬: ⊃⎕SH  x ⋄ x←(¯1↓x) , '?',⍺ ,'"'  ⋄ ⊃⎕SH  x}

⍝fbg '/fapi/v1/time'
fbg←{⍺←⍬⋄ u1←  'https://',fapi,⍵⋄ x ← 'curl -s -X GET "' , u1, '"'⋄⍺≡⍬: ⊃⎕SH  x ⋄ x←(¯1↓x) , '?',⍺ ,'"'  ⋄ ⊃⎕SH  x}
⍝ fbga '/fapi/v1/allOrders'  

fbga←{ u1←  'https://',fapi,⍵⋄ q←  ⍺ ⋄si←⊃⎕sh './sign.sh "' , q ,'" "' , sec , '"'⋄  x←  'curl -s -H "X-MBX-APIKEY: ', api, '" -X GET "', u1,'?' , q ,'&signature=' , si ,'"' ⋄⊃⎕SH x  } 

⍝'symbol=BTCUSDT&side=BUY&type=LIMIT&timeInForce=GTC&quantity=0.02&price=10000' bp '/fapi/v1/order'

fbp ←{ q ← ⍺  ⋄ u ← 'https://',fapi,⍵  ⋄ q1 ←  q ,'&timestamp=', ts   ⋄ si← ⊃⎕sh  './sign.sh "' , q1 , '" "' , sec ,'"' ⋄ x←  'curl -s -H "X-MBX-APIKEY: ', api , '" -X POST "', u ,'" -d "' , q1 , '&signature=' , si ,'" '  ⋄ ⎕sh x }


(ue 'symbol' 'BTCUSDT' 'side' 'BUY'  'type' 'LIMIT' 'timeInForce' 'GTC' )


2⎕fix '∇r←fst' 'r← fbg ''/fapi/v1/time''' '∇'
2⎕fix '∇r←cu arg' 'r← 1⎕C arg,''USDT''' '∇'


fob←{s ← cu ⍵⋄ q←ue 'symbol' s 'limit' '5' ⋄ q fbg '/fapi/v1/depth' }
fbt←{s ← cu ⍵ ⋄ q←ue 'symbol' s  ⋄ q fbg '/fapi/v1/ticker/bookTicker' }
fht←{s ← cu ⍵ ⋄ q←ue 'symbol' s  ⋄ q fbg '/fapi/v1/ticker/24hr' }

fods←{s ← cu ⍵⋄ q← ue 'symbol' s 'timestamp' ts ⋄ q fbga '/fapi/v1/openOrders'}
fpos←{s ← cu ⍵⋄ q← ue 'symbol' s 'timestamp' ts ⋄ q fbga '/fapi/v2/positionRisk'}

fod←{s ← cu ⍵ , q←ue 'symbol' s 'side' 'BUY' 'type' 'LIMIT' 'timeInForce' 'GTC' 'quantity' '0.02' 'price' '10000' ⋄ q bp '/fapi/v1/order'}

fmod←{s ← cu ⍵ , q←ue 'symbol' s 'side' 'BUY' 'type' 'MARKET' 'timeInForce' 'GTC' 'quantity' '0.02'  ⋄ q bp '/fapi/v1/order'}




2⎕fix '∇r←sst' 'r← sbg ''/api/v3/time''' '∇'

sob←{s ← cu ⍵ ⋄ q←ue 'symbol' s 'limit' '5' ⋄ q sbg '/api/v3/depth' }
sbt←{s ← cu ⍵ ⋄ q←ue 'symbol' s  ⋄ q sbg ' /api/v3/ticker/tradingDay' }






)save -force a.dws

