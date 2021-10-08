
%% STOICHIOMETRIC CALIBRATION OF HU TO TISSUE PARAMETERS

%% STEP 1: Scan CATPHAN 604 using Gemini scanner

%  Scanning protocol: 120 keV, 140 mA.s, 1 mm for slice thickness

%% STEP 2: Report mean HU within each tissue substitute

%Gemini_phantom_data = 8x9 double matrix
%     8 rows for 8 materials: air, PMP, LDPE, polystyrene, acrylic, bone
%          20%, bone 50%, and delrin
%     8 cols for each material
%         - 1:7 --> chemical composition (H, C, N, O, P, Ar, Na)
%         - 8   --> mass density (g/cm^3)
%         - 9   --> mean measured HU
load('CATPHAN604_data.mat')

atomic_weight_ts =[1.0079	12.011	14.006	15.999	30.973762   39.948	40.08];
atomic_number_ts =[1	    6	    7	    8	    15	        18	    20];

%% STEP 3: Obtain scanner-specific K1 & K2 values

% Find least-square fit of the measured HU to the calculated HU
% as a function of K1 & K2

min_sqerror = 100000000;
sqerror = 0;
min_k1 = 0;
min_k2 = 0;
for k1 = [-0.01:0.00001:0.01]
    k1
    for k2 = [-0.001:0.000001:0.001]
        for i = 1:8
           % Equation 4.3 in thesis manuscript
           denominador = 1 * (  11.19/atomic_weight_ts(1)*(1 + k1+k2)     +    88.81/atomic_weight_ts(4)* (8 + (8^2.86)*k1+(8^4.64)*k2)     );
           numerador = Gemini_phantom_data(i,8) * sum((Gemini_phantom_data(i,1:7)./atomic_weight_ts(:)')' .* (atomic_number_ts(:)+ (atomic_number_ts(:).^2.86)*k1 + (atomic_number_ts(:).^4.62)*k2));
           u_uwater_cal = numerador/denominador;
           % Equation 2.7 in thesis manuscript
           u_water_meas = Gemini_phantom_data(i,9)/1000+1;
           % Equation 4.6 in thesis manuscript
           sqerror = sqerror +(u_uwater_cal - u_water_meas)^2;
        end
        if min_sqerror > sqerror
           min_sqerror = sqerror;
           min_k1 = k1;
           min_k2 = k2;
        end
        sqerror = 0;
    end
end

%% STEP 4: Compute HU of tissue substitutes according to fitted k1 and k2

for i = 1:8
     % Equation 4.3 in thesis manuscript
     denominador = 1 * (  11.19/atomic_weight_ts(1)*(1 + min_k1+min_k2)     +    88.81/atomic_weight_ts(4)* (8 + (8^2.86)*min_k1+(8^4.64)*min_k2)     );
     numerador = Gemini_phantom_data(i,8) * sum((Gemini_phantom_data(i,1:7)./atomic_weight_ts(:)')' .* (atomic_number_ts(:)+ (atomic_number_ts(:).^2.86)*min_k1 + (atomic_number_ts(:).^4.62)*min_k2));
     % Equation 2.7 in thesis manuscript
     u_uwater_cal = numerador/denominador;
     % Equation 2.7 in thesis manuscript
     HU_TS(i) = (u_uwater_cal-1)*1000;
end

%% STEP 5: Compute HU of ICRP standard tissues (P110) according to fitted K1 and K2

% ICRP.mat = 1x1 struct
%      -  ICRP.atomic_weight: 1x13 matrix
%              weight of 13 chemical elements: H, C, N, O, Na, Mg, P, S,
%              Cl, K, Ca, Fe, I
%      -  ICRP.atomic_number: 1x13 matrix
%              atomic number of 13 chemical elements: H, C, N, O, Na, Mg,
%              P, S, Cl, K, Ca, Fe, I
%      -  ICRP.male_tissues: 53x15 matrix
%              lists the weight percentage of each chemical element,
%              mass density and empirical HU in each standard
%              tissue in the ICRP PUBLICATION 110
ICRP_load = load('ICRP.mat') ;
ICRP_tissues = ICRP_load.ICRP_tissues;

denominador = 1 * (  11.19/ICRP_tissues.atomic_weight(1)*(1 + min_k1+min_k2)     +    88.81/ICRP_tissues.atomic_weight(4)* (8 + (8^2.86)*min_k1+(8^4.64)*min_k2)     );
%MALE
for t = 1:53
    tissue = ICRP_tissues.male_tissues(t,:);
    % Equation 4.3 in thesis manuscript
    numerador = tissue(14) * sum((tissue(1:13)./ICRP_tissues.atomic_weight(:)')' .* (ICRP_tissues.atomic_number(:)+ (ICRP_tissues.atomic_number(:).^2.86)*min_k1 + (ICRP_tissues.atomic_number(:).^4.62)*min_k2));
    u_uwater_cal = numerador/denominador;
    % Equation 2.7 in thesis manuscript
    ICRP_tissues.HU_male_tissues(t,1) = (u_uwater_cal -1)*1000;
end
%FEMALE
for t = 1:53
    tissue = ICRP_tissues.female_tissues(t,:);
    % Equation 4.3 in thesis manuscript
    numerador = tissue(14) * sum((tissue(1:13)./ICRP_tissues.atomic_weight(:)')' .* (ICRP_tissues.atomic_number(:)+ (ICRP_tissues.atomic_number(:).^2.86)*min_k1 + (ICRP_tissues.atomic_number(:).^4.62)*min_k2));
    u_uwater_cal = numerador/denominador;
    % Equation 2.7 in thesis manuscript
    ICRP_tissues.HU_female_tissues(t,1) = (u_uwater_cal -1)*1000;
end

%% STEP 6: Compute HU of Representative Tissues according to fitted K1 and K2

load('representative_tissues.mat')
%  representative_tissues.mat = 11x15 matrix:
%
%     11 rows for 11 representative tissues
%
%     15 cols for each material
%         - 1:14 --> chemical composition (H, C, N, O, Na, Mg, P, S,
%     Cl, Ar, K, Ca, Fe, I)
%         - 15   --> mass density (g/cm^3)


atomic_weight_rt = [1.0079	12.011	14.006	15.999	22.989769	24.312	30.973762	32	35.45	39.948	39.0983	40.08	55.845	126.9045];
atomic_number_rt = [1	6	7	8	11	12	15	16	17	18	19	20	26	53];

denominador = 1 * (  11.19/atomic_weight_rt(1)*(1 + min_k1+min_k2)     +    88.81/atomic_weight_rt(4)* (8 + (8^2.86)*min_k1+(8^4.64)*min_k2)     );
for rt = 1:11
    tissue = representative_tissues(rt,:);
    % Equation 4.3 in thesis manuscript
    numerador = tissue(15) * (   sum((tissue(1:14)./atomic_weight_rt(:)')' .* (atomic_number_rt(:)+ (atomic_number_rt(:).^2.86)*min_k1 + (atomic_number_rt(:).^4.62)*min_k2)) );
    u_uwater_cal = numerador/denominador;
    % Equation 2.7 in thesis manuscript
    HU_representative_tissues(rt,1) = (u_uwater_cal -1)*1000;
end
