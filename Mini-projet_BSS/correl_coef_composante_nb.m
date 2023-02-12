function [Mat_cor] = correl_coef_composante_nb(im1,im2);
N = length(im1);

moy_1 = mean(im1);
moy_2 = mean(im2);

Mat_cor = zeros(2);

ec_1 = std(im1);
ec_2 = std(im2);
ec = [ec_1 ec_2 ]';

moy = [moy_1 moy_2 ]';

ima = [im1(:) im2(:) ];

  for i = 1 : 2,

     for j = 1 : 2, 

  Mat_cor(i,j) = (1/(N*ec(i)*ec(j)))*sum(  ( ima(:,i) - moy(i) ).*( ima(:,j) - moy(j) ) );   
     end
  end




