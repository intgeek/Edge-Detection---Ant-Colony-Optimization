img=imread('lena.bmp');
img1=rgb2gray(img);

II=edge(img1,'sobel');

img=im2double(img1);

X=size(img);
row=X(1,1);
col=X(1,2);

C=0.1;
T=0;
img2=zeros(row,col); 
a=zeros(3,8);
for i=1:row
    for j=1:col
        img(i,j)=img(i,j)*img(i,j);
    end
end
for i=3:row-2
    for j=3:col-2
	         a(1,1)=abs(img(i,j)-img(i-1,j-1));
		 a(2,1)=abs(img(i-1,j+1)-img(i-2,j));
		 a(3,1)=abs(img(i+1,j-1)-img(i,j-2));
        
         
        	 a(1,2)=abs(img(i,j)-img(i-1,j));
		 a(2,2)=abs(img(i,j+1)-img(i-1,j+1));
		 a(3,2)=abs(img(i,j-1)-img(i-1,j-1));
         
        	 a(1,3)=abs(img(i,j)-img(i,j-1));
		 a(2,3)=abs(img(i+1,j)-img(i+1,j-1));
		 a(3,3)=abs(img(i-1,j)-img(i-1,j-1));
         
         
        	 a(1,4)=abs(img(i,j)-img(i-1,j+1));
		 a(2,4)=abs(img(i+1,j+1)-img(i,j+2));
		 a(3,4)=abs(img(i-1,j-1)-img(i-2,j));
         
        	 a(1,5)=abs(img(i,j)-img(i+1,j+1));
		 a(2,5)=abs(img(i+1,j-1)-img(i+2,j));
		 a(3,5)=abs(img(i-1,j+1)-img(i,j+2));
         
         
        	 a(1,6)=abs(img(i,j)-img(i+1,j));
		 a(2,6)=abs(img(i,j+1)-img(i+1,j+1));
		 a(3,6)=abs(img(i,j-1)-img(i+1,j-1));
         
        
        	 a(1,7)=abs(img(i,j)-img(i,j+1));
		 a(2,7)=abs(img(i+1,j)-img(i+1,j+1));
		 a(3,7)=abs(img(i-1,j)-img(i-1,j+1));
        
         
        	 a(1,8)=abs(img(i,j)-img(i+1,j-1));
		 a(2,8)=abs(img(i+1,j+1)-img(i+2,j));
		 a(3,8)=abs(img(i-1,j-1)-img(i,j-2));

		T=max(a);
        T=T';
        t1=max(T);
		img2(i,j)=t1;
		
        
         
    end
   
end

sIM=img2-img-C;
bw=im2bw(sIM,0);
%figure,imshow(bw);
bw1=zeros(row,col);
II1=zeros(row,col);
for i=1:row
    for j=1:col
        if(II(i,j)>0)
            II1(i,j)=1;
        end
    end
end


for i=1:row
    for j=1:col
        if(bw(i,j)>0)
            bw1(i,j)=1;
        end
    end
end


n=4;
NUM=20;
[L,obj] = bwlabel(bw,n);

Iout1 = bw;
for i=1:obj
    fbw = find(L==i);
    if length(fbw) < NUM 
        Iout1(fbw) = 0;
    end
end

%endpoint detection
en=zeros(7555,2);
z=1;
for i=2:row-1
    for j=2:col-1
        if(II1(i,j)==1)
             tot=(II1(i-1,j-1)+II1(i,j+1)+II1(i+1,j+1)+II1(i+1,j)+II1(i+1,j-1)+II1(i,j-1)+II1(i-1,j+1)+II1(i-1,j));
             if(tot==1)
                 en(z,1)=i;
                 en(z,2)=j;
                 z=z+1;
             end
        end
    end
end
img3=zeros(row,col);

%ant position initialisation
%diff=zeros(8,1);
ant_num=z;
tab_list=zeros(ant_num,1502,2);

mem=1;

%intensity diff matrix without noramlisation

eta=zeros(8,1);
prob=zeros(8,1);

%pheromone matrix
 ph=.01.*ones(size(img1));
 alpha=1;
 beta=10;
 rho=.6;
 %c=1;
 sigma=.5;
 pho=.0001;
 img=im2double(img1);
 

%ants movements
for k=1:150
    
for i=1:ant_num
            if(en(i,1)>2&&en(i,2)>2&&en(i,1)<130&&en(i,2)<130)                
            x=en(i,1);
            y=en(i,2);
            tab_list(i,mem,1)=en(i,1);
            tab_list(i,mem,2)=en(i,2);
             a(1,1)=abs(img(x,y)-img(x-1,y-1));
             a(2,1)=abs(img(x-1,y+1)-img(x-2,y));
            a(3,1)=abs(img(x+1,y-1)-img(x,y-2));
        
         
        	 a(1,2)=abs(img(x,y)-img(x-1,y));
		 a(2,2)=abs(img(x,y+1)-img(x-1,y+1));
		 a(3,2)=abs(img(x,y-1)-img(x-1,y-1));
         
        	 a(1,3)=abs(img(x,y)-img(x,y-1));
		 a(2,3)=abs(img(x+1,y)-img(x+1,y-1));
		 a(3,3)=abs(img(x-1,y)-img(x-1,y-1));
         
         
        	 a(1,4)=abs(img(x,y)-img(x-1,y+1));
		 a(2,4)=abs(img(x+1,y+1)-img(x,y+2));
		 a(3,4)=abs(img(x-1,y-1)-img(x-2,y));
         
         a(1,5)=abs(img(x,y)-img(x+1,y+1));
		 a(2,5)=abs(img(x+1,y-1)-img(x+2,y));
		 a(3,5)=abs(img(x-1,y+1)-img(x,y+2));
         
         
         a(1,6)=abs(img(x,y)-img(x+1,y));
		 a(2,6)=abs(img(x,y+1)-img(x+1,y+1));
		 a(3,6)=abs(img(x,y-1)-img(x+1,y-1));
         
        
         a(1,7)=abs(img(x,y)-img(x,y+1));
		 a(2,7)=abs(img(x+1,y)-img(x+1,y+1));
		 a(3,7)=abs(img(x-1,y)-img(x-1,y+1));
        
         
         a(1,8)=abs(img(x,y)-img(x+1,y-1));
		 a(2,8)=abs(img(x+1,y+1)-img(x+2,y));
		 a(3,8)=abs(img(x-1,y-1)-img(x,y-2));
         t=max(a);
         t1=(a(1,1)+a(1,2)+a(1,3)+a(1,4)+a(1,5)+a(1,6)+a(1,7)+a(1,8));
         
             
         

           % s=max(t);
       
            
          
           if(t1~=0)
             m=zeros(8,1);
             prob(1,1)=(((ph(x+1,y-1))^alpha)*((t(1,1))^beta));
             prob(2,1)=(((ph(x+1,y))^alpha)*((t(1,2))^beta));
             prob(3,1)=(((ph(x+1,y+1))^alpha)*((t(1,3))^beta));
             prob(4,1)=(((ph(x,y+1))^alpha)*((t(1,4))^beta));
             prob(5,1)=(((ph(x-1,y+1))^alpha)*((t(1,5))^beta));
             prob(6,1)=(((ph(x-1,y))^alpha)*((t(1,6))^beta));
             prob(7,1)=(((ph(x-1,y-1))^alpha)*((t(1,7))^beta));
             prob(8,1)=(((ph(x,y-1))^alpha)*((t(1,8))^beta));
             %s1=sum(prob);
             %if(s1~=0)
             %prob=prob/s1;
             %end
             
             if(II1(x+1,y-1)==0)
                 m(1,1)=prob(1,1);
             end
             if(II1(x+1,y)==0)
                 m(2,1)=prob(2,1);
             end
             if(II1(x+1,y+1)==0)
                 m(3,1)=prob(3,1);
             end
             if(II1(x,y+1)==0)
                 m(4,1)=prob(4,1);
             end
             if(II1(x-1,y+1)==0)
                 m(5,1)=prob(5,1);
             end
             if(II1(x-1,y)==0)
                 m(6,1)=prob(6,1);
             end
             if(II1(x-1,y-1)==0)
                 m(7,1)=prob(7,1);
             end
             if(II1(x,y-1)==0)
                 m(8,1)=prob(8,1);
             end
             
             temp=max(m);
             if(temp==prob(1,1))
                 p=x+1;
                 q=y-1;
             elseif(temp==prob(2,1))
                    p=x+1;
                    q=y;
             elseif(temp==prob(3,1))
                    p=x+1;
                    q=y+1;
             elseif(temp==prob(4,1))
                    p=x;
                    q=y+1;
             elseif(temp==prob(5,1))
                    p=x-1;
                    q=y+1;
             elseif(temp==prob(6,1))
                    p=x-1;
                    q=y;
             elseif(temp==prob(7,1))
                    p=x-1;
                    q=y-1;
             elseif(temp==prob(8,1))
                    p=x;
                    q=y-1;
             end
              img3(p,q)=1;
             en(i,1)=p;
             en(i,2)=q;
            
           end
           
   
            ph(x,y)=(((1-sigma)*ph(x,y))+(sigma*pho));
            end
            
end
mem=mem+1;
stop=0;
%meeting face to face
for l=1:ant_num
   for j=1:ant_num
       if(l~=j)
           if((en(l,1)==en(j,1))&&(en(l,2)==en(j,2)))
               stop=1;
               en(l,1)=0;
               en(l,2)=0;
               en(j,2)=0;
               en(j,1)=0;
           end
       end
   end
end

%touching tracks
if(stop==0)
    for l=1:ant_num
           if(en(l,1)>1&&en(l,2)>1&&en(l,1)<131&&en(l,2)<131)
           p=en(l,1);
           q=en(l,2);
           if(img3(p,q)==1)
               en(l,1)=0;
               en(l,2)=0;
               stop=1;
           end
           end
    end
end

%adaptive tabulist

if(stop==0)
    for l=1:ant_num
        for m=1:(mem-1)
            if((tab_list(l,m,1)==tab_list(l,mem,1))&&(tab_list(l,m,2)==tab_list(l,mem,2)))
                en(l,1)=0;
                en(l,2)=0;
                stop=1;
            end
        end
    end
end
%global pheromone update
 
    %if(mem-1~=0)
    %delta_ph=c/mem-1;
    %else
    %delta_ph=0; 
    %end
    delta_ph=(mem-1)/512;
    ph=(((1-rho).*ph)+(rho*delta_ph));

 
end
I1=img3+II1+bw;
n=4;
NUM=10;
[L,obj] = bwlabel(I1,n);

Iout = I1;
for i=1:obj
    fbw = find(L==i);
    if length(fbw) < NUM 
        Iout(fbw) = 0;
    end
end

figure,imshow(II);
figure,imshow(bw);
figure,imshow(img3);
figure,imshow(img3+Iout1);
figure,imshow(img3+II1);
figure,imshow(img3+II1+Iout);
figure,imshow(Iout);