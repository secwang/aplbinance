#!/usr/bin/env dyalogscript

⎕IO ← 0
(⎕NS⍬).(_←enableSALT⊣⎕CY'salt')

'display' ⎕cy 'dfns' 
pp←{⍵⊣⎕←#.display ⍵}

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
