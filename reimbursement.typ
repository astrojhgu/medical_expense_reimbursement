#let name="张三"
#let dep="某部"
#let id="9527"
#let phone="13812341234"
#let total="1234567.89"
#let date="2024/2/29"
#let ninvoice="1"


//dont touch following codes
//#let menzhen="12345.10"
//#let zhuyuan="1000.11"

#let (yyyy,mm,dd)=date.split("/")

#let mod(n, m) = {
  while n >= m {
    n -= m
  }

  return n
}

#let arabic_to_chinese(num_str:str)={
  let chinese_numerals = ("0": "零", "1": "壹", "2": "贰", "3": "叁", "4": "肆", "5": "伍", "6": "陆", "7": "柒", "8": "捌", "9": "玖")
  let unit_list = ("", "拾", "佰", "仟")
  let decimal_list = ("角", "分")
  let result=""
  let (integer_part, ..decimal_part)=num_str.split(".")
  
  let n=calc.min(decimal_part.len(),2)
  

  decimal_part=decimal_part.slice(0,n)
  let integer_result = ""
  
  for (i,digit) in integer_part.rev().clusters().enumerate(){
    if digit!="0"{
      integer_result=chinese_numerals.at(digit)+unit_list.at(mod(i,4))+integer_result
    }
    else if (i==0 or mod(i,4)!=0 and integer_result.at(0)!="零"){
      integer_result="零"+integer_result
    }
    if mod(i,4)==3 and integer_part.len()>4{
      integer_result="万"+integer_result
    }else if mod(i, 8)==7{
      integer_result="亿"+integer_result
    }  
    //result+=str(i)
  }
  result+=integer_result+"元"
  if decimal_part.len()>0{
      for (i, digit) in decimal_part.at(0).clusters().enumerate(){
        if digit!="0"{
          result+=chinese_numerals.at(digit)+decimal_list.at(i)
        }
        else if i==0 {
          result+="零"
        }
      }
  }else{
    result+="整"
  }
  result
}

#set page(paper:"a4",flipped: true,margin:(top:75pt, bottom:0pt))
#let zh_hei = ("SimHei",)
#set align(center)
#let ts=0.3cm//title spacing
#set text(size:24pt,font: zh_hei,spacing:200%)
国#h(ts)家#h(ts)天#h(ts)文#h(ts)台#h(ts)医#h(ts)疗#h(ts)费#h(ts)报#h(ts)销#h(ts)单
#v(-0.5cm)
#line(stroke: 1.5pt, length:60%)

#set text(size:14pt,spacing:100%)
#set align(right)
#yyyy 年#mm 月#dd 日#h(5cm) 单据数#ninvoice 张#h(1cm)

#set align(left)
#grid(columns:(1.0cm,1cm,0.5cm,26cm),
[],
block()[
  #set text(size:15pt,spacing:100%)
  #path(fill:none, stroke: (dash:"loosely-dotted",thickness:1.5pt), closed:false, (8pt,0pt),(8pt,100pt))
  装\ #v(1cm)订\ #v(1cm)线
  #path(fill:none, stroke: (dash:"loosely-dotted",thickness:1.5pt), closed:false, (8pt,0pt),(8pt,100pt))
  ],[]
  ,[
   #table(columns:(6cm,9cm,3.8cm,3.8cm),
   align:horizon+center,
   
   inset:(y:22pt),
  [部~~~~~~~~~~~~~门],[#dep],[工~资~号],[#id],
  [职~~~工~~~姓~~~名],[#name],[联系电话],[#phone],
  [发~票~金~额~(大写)],[
    #set text(size:13pt)
    #arabic_to_chinese(num_str:total)],[报销比例],[],
  [住院实报金额(大写)],[
    #set text(size:13pt)
    //#arabic_to_chinese(num_str:zhuyuan)
    ],[小写金额],[
      //#zhuyuan
      ],
  [门诊实报金额(大写)],[
    #set text(size:13pt)
    //#arabic_to_chinese(num_str:menzhen)
    ],[小写金额],[
      //#menzhen
      ],
  [医~~务~~室~~意~~见],[],[报~销~人],[],
   )

   #h(0.5cm)台领导#h(2.5cm)人事处#h(3.5cm)报销单位负责人#h(2.5cm)审核#h(2.5cm)出纳
  ]
)
