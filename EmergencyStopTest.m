S = serial('COM10');
S.BaudRate = 115200;
S.Terminator = 'CR';
fopen(S);
i=1;
vect = zeros(1,300);
while(i<(11520*10))
    number = fread(S,1,'uchar')
    pause(0.00008);
    vect(i) = number;
    i = i+1
end
fclose(S);
