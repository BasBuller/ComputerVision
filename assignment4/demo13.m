% this function gives a demo of the Lucas Kanade tracker. The sum of the
% euclidean distance between the tracked points and the groundtruth is
% plotted for every frame.

function demo2()
%load points
Points = textread('model_house/measurement_matrix.txt');

for num = 1:101;
    imageLoc = ['model_house/frame' num2str(num, '%08d') '.jpg'];
    im = double(imread(imageLoc))/255;
    if num == 1
        Imf=zeros(size(im,1),size(im,2),101);
    end
    Imf(:,:,num)=im;
%     figure(1)
%     imshow(im);
%     hold on 
%     plot(Points(num*2-1,:),Points(num*2,:),'b.');
%     pause(0.1)finding dt between images
end

%track pointsline([pointsx(i, :); pts((2*i-1), :)], [pointsy(i, :); pts((2*i), :)])
[pointsx,pointsy]=LKtracker(Points,Imf,1,0);

save('Xpoints','pointsx')
save('Ypoints','pointsy')


%% euclidean distance per frame
dis_x= pointsx - Points(1:2:end,:);
dis_y= pointsy - Points(2:2:end,:);
figure(2)
eudis=((dis_x).^2+(dis_y).^2);
LS=sqrt(sum(eudis,2));
plot(LS)
xlabel('image #')
ylabel('sum of LS-error')
end