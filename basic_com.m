clear all;
close all;
clc;


port = 'COM17';
Baud_Rate = 9600;
Data_Bits = 8;
Stop_Bits = 1;
%Default for Parity & Flow Control are none.  


S = serial(port,'BaudRate',Baud_Rate,'DataBits',Data_Bits,'StopBits',Stop_Bits);
fopen(S);

read=zeros(1,1000);
filter=zeros(1,1000);
i=1;

while(i<1000)
	input=fscanf(S);
read(1,i)=str2double(input);
i=i+1;
%fclose(S);
end

j=2;
band=0.503;
while(j<1000)
	filter(1,j)=read(1,j-1)*band+read(1,j)*(1-band);
	j=j+1;
end

plot(read(1,:));
hold on;
grid on;
plot(filter(1,:));
fclose(S);