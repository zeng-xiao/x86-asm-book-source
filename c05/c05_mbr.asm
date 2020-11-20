         mov ax,0xb800                 ;es寄存器指向文本模式的显示缓冲区
         mov es,ax

         mov byte [es:0x00],'z'
         mov byte [es:0x01],0x07
         mov byte [es:0x02],'e'
         mov byte [es:0x03],0x07
         mov byte [es:0x04],'n'
         mov byte [es:0x05],0x07
         mov byte [es:0x06],'g'
         mov byte [es:0x07],0x07
         mov byte [es:0x08],' '
         mov byte [es:0x09],0x07
         mov byte [es:0x0a],'x'
         mov byte [es:0x0b],0x07
         mov byte [es:0x0c],"i"
         mov byte [es:0x0d],0x07
         mov byte [es:0x0e],'a'
         mov byte [es:0x0f],0x07
         mov byte [es:0x10],'o'
         mov byte [es:0x11],0x07
         mov byte [es:0x12],' '
         mov byte [es:0x13],0x07
         mov byte [es:0x14],' '
         mov byte [es:0x15],0x07
         mov byte [es:0x16],' '
         mov byte [es:0x17],0x07
         mov byte [es:0x18],':'
         mov byte [es:0x19],0x07

         mov ax,number                 ;取得标号number的偏移地址
         mov bx,10                     ;bx保存被除数,div指令使用bx寄存器的值作为被除数

         mov cx,cs
         mov ds,cx

         mov dx,0
         div bx
         mov [0x7c00+number+0x00],dl   ;保存个位上的数字

         ;求十位上的数字
         xor dx,dx
         div bx
         mov [0x7c00+number+0x01],dl   ;保存十位上的数字

         xor dx,dx
         div bx
         mov [0x7c00+number+0x02],dl   ;保存百位上的数字

         ;求千位上的数字
         xor dx,dx
         div bx
         mov [0x7c00+number+0x03],dl   ;保存千位上的数字

         xor dx,dx
         div bx
         mov [0x7c00+number+0x04],dl   ;保存万位上的数字

         mov al,[0x7c00+number+0x04]    ;将计算结果送到al寄存器中
         add al,0x30                    ;加上0x30得到这个数字的ASCII码
         mov [es:0x1a],al               ;得到的ASCII码送到指定的位置
         mov byte [es:0x1b],0x04        ;显示属性为黑底红字，无闪烁无加亮
         
         mov al,[0x7c00+number+0x03]
         add al,0x30
         mov [es:0x1c],al
         mov byte [es:0x1d],0x04
         
         mov al,[0x7c00+number+0x02]
         add al,0x30
         mov [es:0x1e],al
         mov byte [es:0x1f],0x04

         mov al,[0x7c00+number+0x01]
         add al,0x30
         mov [es:0x20],al
         mov byte [es:0x21],0x04

         mov al,[0x7c00+number+0x00]
         add al,0x30
         mov [es:0x22],al
         mov byte [es:0x23],0x04
         
         mov byte [es:0x24],'D'
         mov byte [es:0x25],0x07
          
   infi: jmp near infi                 ;无限循环
      
  number db 0,0,0,0,0
  
  times 203 db 0
            db 0x55,0xaa
