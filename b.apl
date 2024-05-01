#!/usr/bin/env dyalogscript ENABLE_CEF=0
⎕IO ← 0
⎕PP←12 ⍝ for orderid
(⎕NS⍬).(_←enableSALT⊣⎕CY'salt')
)copy dfns cmpx timestamp
⍝]box on -style=max -trains=tree -fns=on

sym level ← 'btc' '10'

sapi fapi api sec ← 'api.binance.com' 'fapi.binance.com' '' '' ⍝ endpoint,api,key

display←{ ⎕IO ⎕ML←0 ⋄ ⍺←1 ⋄ chars←⍺⊃'..''''|-' '┌┐└┘│─' ⋄ tl tr bl br vt hz←chars ⋄ box←{ vrt hrz←(¯1+⍴⍵)⍴¨vt hz ⋄ top←(hz,'⊖→')[¯1↑⍺],hrz ⋄ bot←(⊃⍺),hrz ⋄ rgt←tr,vt,vrt,br ⋄ lax←(vt,'⌽↓')[¯1↓1↓⍺],¨⊂vrt ⋄ lft←⍉tl,(↑lax),bl ⋄ lft,(top⍪⍵⍪bot),rgt } ⋄ deco←{⍺←type open ⍵ ⋄ ⍺,axes ⍵} ⋄ axes←{(-2⌈⍴⍴⍵)↑1+×⍴⍵} ⋄ open←{(1⌈⍴⍵)⍴⍵} ⋄ trim←{(~1 1⍷∧⌿⍵=' ')/⍵} ⋄ type←{{(1=⍴⍵)⊃'+'⍵}∪,char¨⍵} ⋄ char←{⍬≡⍴⍵:hz ⋄ (⊃⍵∊'¯',⎕D)⊃'#~'}∘⍕ ⋄ line←{(6≠10|⎕DR' '⍵)⊃' -'}⋄ { 0=≡⍵:' '⍪(open ⎕FMT ⍵)⍪line ⍵ ⋄ 1 ⍬≡(≡⍵)(⍴⍵):'∇' 0 0 box ⎕FMT ⍵ ⋄ 1=≡⍵:(deco ⍵)box open ⎕FMT open ⍵ ⋄ ('∊'deco ⍵)box trim ⎕FMT ∇¨open ⍵ }⍵ }
pp←{⍵⊣⎕←#.display ⍵}
assert←{⍺←'assertion failure' ⋄ 0∊⍵:⍺ ⎕SIGNAL 8 ⋄ shy←0} ⍝ https://www.jsoftware.com/papers/APL_exercises/
2⎕fix '∇r←ts' 'tst ← (20 ⎕dt''Z'')×1000' 'tst ← ''I13'' ⎕fmt tst' 'r←tst[0;]' '∇'
he ← {((2÷⍨⍴⍵) ,2) ⍴ ⍵}
ue←{x←he ⍵⋄ m← x[;0] ,¨'=',¨⍕¨ x[;1]⋄ ¯1↓ ∊m,¨'&'} ⍝   ue 'abc' 'example' 'def' '123' 'ghi' '5.6'
sbg←{⍺←⍬⋄ u1←  'https://',sapi,⍵⋄ x ← 'curl -s -X GET "' , u1, '"'⋄⍺≡⍬: ⊃⎕SH  x ⋄ x←(¯1↓x) , '?',⍺ ,'"'  ⋄ ⊃⎕SH  x}
fbg←{⍺←⍬⋄ u1←  'https://',fapi,⍵⋄ x ← 'curl -s -X GET "' , u1, '"'⋄⍺≡⍬: ⊃⎕SH  x ⋄ x←(¯1↓x) , '?',⍺ ,'"'  ⋄ ⊃⎕SH  x}
fbga←{ u1←  'https://',fapi,⍵⋄ q←  ⍺ ⋄si←⊃⎕sh './sign.sh "' , q ,'" "' , sec , '"'⋄  x←  'curl -s -H "X-MBX-APIKEY: ', api, '" -X GET "', u1,'?' , q ,'&signature=' , si ,'"' ⋄⊃⎕SH x} 
fbp ←{  u ← 'https://',fapi,⍵  ⋄ q1 ←  ⍺  ⋄ si← ⊃⎕sh  './sign.sh "' , q1 , '" "' , sec ,'"' ⋄ x←  'curl -s -H "X-MBX-APIKEY: ', api , '" -X POST "', u ,'" -d "' , q1 , '&signature=' , si ,'" '  ⋄ ⊃⎕sh x }
fbd ←{  u ← 'https://',fapi,⍵  ⋄ q1 ←  ⍺  ⋄ si← ⊃⎕sh  './sign.sh "' , q1 , '" "' , sec ,'"' ⋄ x←  'curl -s -H "X-MBX-APIKEY: ', api , '" -X DELETE "', u ,'" -d "' , q1 , '&signature=' , si ,'" '  ⋄ ⊃⎕sh x }
2⎕fix '∇ fst' 'fbg ''/fapi/v1/time'' '  '∇'
2⎕fix '∇r←finfo' 'r←fbg ''/fapi/v1/exchangeInfo'' ' '∇'
2⎕fix '∇r←cu arg' 'r← 1⎕C arg,''USDC''' '∇'
fob←{s ← cu ⍵⋄ q←ue 'symbol' s 'limit' '5' ⋄ q fbg '/fapi/v1/depth' }
fbt←{s ← cu ⍵ ⋄ q←ue 'symbol' s  ⋄ q fbg '/fapi/v1/ticker/bookTicker' }
fht←{s ← cu ⍵ ⋄ q←ue 'symbol' s  ⋄ q fbg '/fapi/v1/ticker/24hr' }
fods←{s ← cu ⍵⋄ q← ue 'symbol' s 'timestamp' ts ⋄ q fbga '/fapi/v1/openOrders'}
fqo←{s id ←⍵⋄s ← cu s⋄ q← ue 'symbol' s 'orderId' id 'timestamp' ts ⋄ q fbga '/fapi/v1/order'}
fco←{s id ←⍵⋄s ← cu s⋄ q← ue 'symbol' s 'orderId' id 'timestamp' ts ⋄ q fbd '/fapi/v1/order'}
fpos←{s ← cu ⍵⋄ q← ue 'symbol' s 'timestamp' ts ⋄ q fbga '/fapi/v2/positionRisk'}
fca←{s ← cu ⍵⋄ q← ue 'symbol' s 'timestamp' ts ⋄ q fbd '/fapi/v1/allOpenOrders'}
fcal←{s ← cu ⍵⋄ q← ue 'symbol' s 'timestamp' ts ⋄ q fbd '/fapi/v1/allOpenOrders'}
ftl←{s ← cu ⍵⋄ q← ue 'symbol' s 'timestamp' ts ⋄ q fbga '/fapi/v1/userTrades'}
fdep←{s ← cu ⍵⋄ q← ue 'symbol' s 'limit' 5 ⋄ q fbg '/fapi/v1/depth'}
fdep100←{s ← cu ⍵⋄ q← ue 'symbol' s 'limit' 100 ⋄ q fbg '/fapi/v1/depth'}
2⎕fix '∇r←fbal' 'fbalq← ue ''timestamp'' ts' 'r←fbalq fbga ''/fapi/v2/balance''' '∇'
⍝fodl 'auction' 'buy' '1' '10'
fodl←{x← ⍵⋄s si q p ← x ⋄ si← 1⎕C si ⋄ s ← cu s⋄ qv ← 'symbol' s 'side' si 'type' 'LIMIT' 'timeInForce' 'GTC' 'quantity' q 'price' p 'timestamp' ts ⋄ q←ue qv⋄q fbp '/fapi/v1/order'}
⍝fodm 'auction' 'buy' '1' 
fodm←{x← ⍵⋄s si q ← x  ⋄si← 1⎕C si ⋄ s ← cu s⋄ qv ← 'symbol' s 'side' si 'type' 'MARKET' 'quantity' q 'timestamp' ts ⋄ q←ue qv⋄q fbp '/fapi/v1/order'}
fodsm←{s si q  sp← ⍵ ⋄ si← 1⎕C si ⋄ s ← cu s⋄ qv ← 'symbol' s 'side' si 'type' 'STOP_MARKET'  'quantity' q  'stopPrice' sp 'timestamp' ts ⋄ q←ue qv⋄q fbp '/fapi/v1/order'}
2⎕fix '∇ sst' 'sbg ''/api/v3/time'' ' '∇'
sob←{s ← cu ⍵ ⋄ q←ue 'symbol' s 'limit' '5' ⋄ q sbg '/api/v3/depth' }
sbt←{s ← cu ⍵ ⋄ q←ue 'symbol' s  ⋄ q sbg ' /api/v3/ticker/tradingDay' }
tie←{ 0::⎕SIGNAL  ⎕EN ⋄ 22::⍵ ⎕NCREATE 0 ⋄ ⍵ ⎕NTIE 0 } ⍝https://github.com/Co-dfns/Co-dfns/blob/c460452dd08c00a22b8a99e1a6937e5836d2fdce/cmp/util.apl#L57
put←{ s←(¯128+256|128+'UTF-8'⎕UCS ⍵)⎕NAPPEND(t←tie ⍺)83⋄ 1:r←s⊣⎕NUNTIE t }
log←{fn msg ← ⍵ ⋄  t ← (timestamp∘'') ⎕ts ⋄ c ←  t  , msg ,(⎕UCS 10) ⋄ fn put c}
lo←{log 'a.log'  ⍵}
clo←{ msg←⍵ ⋄ t ← (timestamp∘'') ⎕ts ⋄ c ←  t  , msg ⋄ ⎕←c }
2⎕fix '∇r←bside' 'r←1 ⎕C side' '∇'
osidei ← {(bside≡'BUY'):'SELL'⋄ 'BUY'}
2⎕fix '∇r←oside' 'r←osidei 0' '∇'
ch←{d←+/1⍷⍵[;3]⋄ l← d÷⍨1-⍨≢⍵[;3] ⋄ c←1↓[1] d l ⍴1↓⍵[;2] ⋄ h← 2↓⍵[;1]↑⍨l+1 ⋄ c h}
rss←{t n c← ⍵⋄c⌷⍨(⍳⍴c[;n])/⍨((⊂t)≡¨c[;n]) }
ods ← {x← sym ⍵ ⋄r←⎕JSON  fqo  x⋄ r1← ⍎r.price ⋄r.status r1 } ⍝ sometime ods error?
di ← {cp h l←⍵ ⋄ (bside≡'BUY'):100×(h-cp)÷h ⋄ 100×(cp-l)÷l }
ti ← {t←⎕JSON fht sym ⋄ cp ← ⍎t.lastPrice ⋄ h←⍎t.highPrice ⋄ l←⍎t.lowPrice  ⋄ cp h l }
rp←{(bside≡'BUY'):100÷⍨⍵×⍨(100-⍎step) ⋄ 100÷⍨⍵×⍨(100+⍎step)}
rd← {id oid status op cp h l rp  ← ⍵ ⋄ i← di rp h l ⋄ ii ← ⊃⍸i<rgs ⋄ ii}
cko←{⍵≡⍬:⍬ ⋄ r←⍵  ⋄cp h l ← ti 0 ⋄ m←(⊃2÷⍨⍴r)2⍴r ⋄ ma←ods¨m[;1] ⋄ j←  m,(⊃2÷⍨⍴r)2⍴⊃,/ma ⋄ j← l,⍨h,⍨cp,⍨j⋄ n←j[(~{(⊂'FILLED'≡⍵)∨(⊂'CANCELED'≡⍵)}¨j[;2])/⍳⍴j[;2];] ⋄ n≡0 4⍴0:⍬ ⋄  rpc ← rp n[;3] ⋄ n ← rpc,⍨n ⋄ ni ← rd¨⊂[1]n ⋄ oi←n[;0] ⋄  rf ← ((oi[⍸0=ni])@(⍸0=ni)) oi ⋄ n[;0]←rf ⋄ ,n[;0 1]}
pre←{1>⍎⍵:1-⍨('1'≡¨⍵)/⍳⍴⍵⋄0} 
sqv←{s←cu ⍵ ⋄ x←finfo ⋄ t←(⎕JSON x).symbols ⋄ f←'filters'{⍵⍎¨⊂⍺}t/⍨s{⍺∘(∨/⍷)¨⍵}t.symbol⋄ ff←⊃f ⋄ ⎕JSON ff}
sq←{s←cu ⍵ ⋄ x←finfo ⋄ t←(⎕JSON x).symbols ⋄ f←'filters'{⍵⍎¨⊂⍺}t/⍨s{⍺∘(∨/⍷)¨⍵}t.symbol⋄ ff←⊃f⋄tk ← 'tickSize'{⍵⍎¨⊂⍺}ff/⍨'PRICE_FILTER'{⍺∘(∨/⍷)¨⍵}ff.filterType  ⋄  ff←⊃f ⋄mq ← 'minQty'{⍵⍎¨⊂⍺}ff/⍨'LOT_SIZE'{⍺∘(∨/⍷)¨⍵}ff.filterType ⋄r1←⌊⊃pre¨tk ⋄ r2← ⌊⊃pre¨mq⋄ r1 r2 }
ff ← {x←⍵ ⋄ a←⍺⋄ a=0: ⌊⍵ ⋄x≥1:{⎕PP←((⍴⍕⌊x)+a⌈⍴⍕⌊0.1+10×x-⌊x) ⋄ ⍕x}0 ⋄ x<1:{m←⍕x⋄ (2+a)↑m}0}



)save -force b.dws


