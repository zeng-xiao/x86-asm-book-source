         jmp near start
         
  mytext db 'L',0x07,'a',0x07,'b',0x07,'e',0x07,'l',0x07,' ',0x07,'o',0x07,\
            'f',0x07,'f',0x07,'s',0x07,'e',0x07,'t',0x07,':',0x07
  number db 0,0,0,0,0
  
  start:
         mov ax,0x7c0                  ;�������ݶλ���ַ 
         mov ds,ax
         
         mov ax,0xb800                 ;���ø��Ӷλ���ַ 
         mov es,ax
         
         cld
         ;movswָ���Դ��ַ��ds:siָ����Ŀ�ĵ�ַ��es:diָ��
         ;������cxָ��
         mov si,mytext                 
         mov di,0
         ;����2����Ϊmytext�������db��ʽ��������ʹ��movswָ��
         mov cx,(number-mytext)/2      ;ʵ���ϵ��� 13
         rep movsw                      ;ִ��cx��movsw����
     
         ;�õ�����������ƫ�Ƶ�ַ
         mov ax,number
         
         ;���������λ
         mov bx,ax                      ;bx��Ϊ�ڴ��ַ����
         mov cx,5                      ;ѭ������ 
         mov si,10                     ;���� 
  digit: 
         xor dx,dx                      ;ÿ�μ���ǰ����������
         div si
         mov [bx],dl                   ;������λ
         inc bx                         ;bx��Ϊ�ڴ��ַ����
         loop digit                     ;��cx����0ʱѭ��һֱִ����ȥ
         
         ;��ʾ������λ
         mov bx,number                  ;ƫ�Ƶ�ַ������bx��
         mov si,4                       ;����������si��
   show:
         mov al,[bx+si]                 ;ȡ����һλ������al��
         add al,0x30                    ;��0x30�õ���Ӧ��ASCII��
         mov ah,0x04                    ;��ʾ�����Ǻڵ׺���
         mov [es:di],ax                 ;�洢����ʾ������
         add di,2                       ;�ƶ�����һ����ʾ����������2����ΪASCII��Ҫ�����ֽ�
         dec si                         ;�ƶ�����һ����Ҫ��ʾ����λ
         jns show                       ;jns��SF��Ϊ1ʱ����ת����һ��ָ��dec si����֮�����siС��0����SFΪ1
         
         mov word [es:di],0x0744

         jmp near $

  times 510-($-$$) db 0                 ;$Ϊ��ǰ�������б�ǣ�$$Ϊnasm�ṩ�ĵ�ǰ���ε���ʼ����ַ��510��512-2�ֽ�(0x55,0xaa�����ֽ�)
                   db 0x55,0xaa
