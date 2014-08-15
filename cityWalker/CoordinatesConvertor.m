//
//  CoordinatesConvertor.m
//  cityWalker
//
//  Created by bluesWalker on 7/24/14.
//  Copyright (c) 2014 Newcastle University. All rights reserved.
//

#import "CoordinatesConvertor.h"
#import "Coordinate.h"

@implementation CoordinatesConvertor

- (Coordinate *)toWGS84FromEasting:(double)easting Northing:(double)northing {
    double height = 0;
    
    double lat1 = [self enToLat_Easting:easting Northing:northing a:6377563.396 b:6356256.910 e0:400000 n0:-100000 f0:0.999601272 φ0:49.00000 λ0:-2.00000];
    double lon1 = [self enToLon_Easting:easting Northing:northing a:6377563.396 b:6356256.910 e0:400000 n0:-100000 f0:0.999601272 φ0:49.00000 λ0:-2.00000];
    
    double x1 = [self latLonHtoX_φ:lat1 λ:lon1 H:height a:6377563.396 b:6356256.910];
    double y1 = [self latLonHtoY_φ:lat1 λ:lon1 H:height a:6377563.396 b:6356256.910];
    double z1 = [self latHtoZ_φ:lat1 H:height a:6377563.396 b:6356256.910];
    
    double x2 = [self helmertX_X:x1 Y:y1 Z:z1 DX:446.448 Y_Rot:0.2470 Z_Rot:0.8421 s:-20.4894];
    double y2 = [self helmertY_X:x1 Y:y1 Z:z1 DY:-125.157 X_Rot:0.1502 Z_Rot:0.8421 s:-20.4894];
    double z2 = [self helmertZ_X:x1 Y:y1 Z:z1 DZ:542.060 X_Rot:0.1502 Y_Rot:0.2470 s:-20.4894];
    
    double latitude = [self xyzToLat_X:x2 Y:y2 Z:z2 a:6378137.000 b:6356752.313];
    double longitude = [self xyzToLon_X:x2 Y:y2];
    
    return [[Coordinate alloc] initWithLatitude:latitude Longitude:longitude];
}

- (double)enToLat_Easting:(double)easting Northing:(double)northing a:(double)a b:(double)b e0:(double)e0 n0:(double)n0 f0:(double)f0 φ0:(double)φ0 λ0:(double)λ0 {
    
    double φ0Rad = [self toRadians:φ0];
    //    double λ0Rad = [self toRadians:λ0];
    
    double af0 = a * f0;
    double bf0 = b * f0;
    double e2 = (pow(af0, 2) - pow(bf0, 2)) / pow(af0, 2);
    double n = (af0 - bf0) / (af0 + bf0);
    double Et = easting - e0;
    
    double φd = [self initialLat_North:northing n0:n0 afo:af0 φ0:φ0Rad n:n bfo:bf0];
    
    double ν = af0 / (sqrt(1 - (e2 * (pow(sin(φd), 2)))));
    double ρ = (ν * (1 - e2)) / (1 - (e2 * pow(sin(φd), 2)));
    double η2 = (ν / ρ) - 1;
    
    double VII = (tan(φd)) / (2 * ρ * ν);
    double VIII = ((tan(φd)) / (24 * ρ * pow(ν, 3))) * (5 + (3 * (pow(tan(φd), 2))) + η2 - (9 * η2 * (pow(tan(φd), 2))));
    double IX = ((tan(φd)) / (720 * ρ * pow(ν,5))) * (61 + (90 * (pow(tan(φd),2))) + (45 * (pow(tan(φd),4))));
    
    double enToLat = [self toDegrees:φd - (pow(Et,2) * VII) + (pow(Et,4) * VIII) - (pow(Et,6) * IX)];
    
    return enToLat;
}

- (double)enToLon_Easting:(double)easting Northing:(double)northing a:(double)a b:(double)b e0:(double)e0 n0:(double)n0 f0:(double)f0 φ0:(double)φ0 λ0:(double)λ0 {
    
    double φ0Rad = [self toRadians:φ0];
    double λ0Rad = [self toRadians:λ0];
    
    double af0 = a * f0;
    double bf0 = b * f0;
    double e2 = (pow(af0, 2) - pow(bf0, 2)) / pow(af0, 2);
    double n = (af0 - bf0) / (af0 + bf0);
    double Et = easting - e0;
    
    double φd = [self initialLat_North:northing n0:n0 afo:af0 φ0:φ0Rad n:n bfo:bf0];
    
    double ν = af0 / (sqrt(1 - (e2 * (pow(sin(φd), 2)))));
    double ρ = (ν * (1 - e2)) / (1 - (e2 * pow(sin(φd), 2)));
    //    double η2 = (ν / ρ) - 1;
    
    double X = (pow(cos(φd),-1)) / ν;
    double XI = ((pow(cos(φd), -1)) / (6 * pow(ν, 3))) * ((ν / ρ) + (2 * (pow(tan(φd), 2))));
    double XII = ((pow(cos(φd), -1)) / (120 * pow(ν, 5))) * (5 + (28 * (pow(tan(φd), 2))) + (24 * (pow(tan(φd), 4))));
    double XIIA = ((pow(cos(φd), -1)) / (5040 * pow(ν, 7))) * (61 + (662 * (pow(tan(φd), 2))) + (1320 * (pow(tan(φd), 4))) + (720 * (pow(tan(φd), 6))));
    
    double enToLon = [self toDegrees:(λ0Rad + (Et * X) - (pow(Et, 3) * XI) + (pow(Et, 5) * XII) - (pow(Et, 7) * XIIA))];
    
    return enToLon;
}

- (double)initialLat_North:(double)north n0:(double)n0 afo:(double)afo φ0:(double)φ0 n:(double)n bfo:(double)bfo {
    
    double φ1 = ((north - n0) / afo) + φ0;
    
    double M = [self marc_bf0:bfo n:n φ0:φ0 φ:φ1];
    
    double φ2 = ((north - n0 - M) / afo) + φ1;
    
    while (abs(north - n0 - M) > 0.00001) {
        φ2 = ((north - n0 -M) / afo) + φ1;
        M = [self marc_bf0:bfo n:n φ0:φ0 φ:φ2];
        φ1 = φ2;
    }
    
    return φ2;
}

- (double)latLonHtoX_φ:(double)φ λ:(double)λ H:(double)H a:(double)a b:(double)b {
    
    double φRad = [self toRadians:φ];
    double λRad = [self toRadians:λ];
    
    double e2 = (pow(a, 2) - pow(b, 2)) / pow(a, 2);
    double V = a / (sqrt(1 - (e2 * (pow(sin(φRad), 2)))));
    
    return (V + H) * (cos(φRad)) * (cos(λRad));
}

- (double)latLonHtoY_φ:(double)φ λ:(double)λ H:(double)H a:(double)a b:(double)b {
    
    double φRad = [self toRadians:φ];
    double λRad = [self toRadians:λ];
    
    double e2 = (pow(a, 2) - pow(b, 2)) / pow(a, 2);
    double V = a / (sqrt(1 - (e2 * (pow(sin(φRad), 2)))));
    
    return (V + H) * (cos(φRad)) * (sin(λRad));
}

- (double)latHtoZ_φ:(double)φ H:(double)H a:(double)a b:(double)b {
    
    double φRad = [self toRadians:φ];
    
    double e2 = (pow(a, 2) - pow(b, 2)) / pow(a, 2);
    double V = a / (sqrt(1 - (e2 * (pow(sin(φRad), 2)))));
    
    return ((V * (1 - e2)) + H) * (sin(φRad));
    
    return 0;
}

- (double)helmertX_X:(double)X Y:(double)Y Z:(double)Z DX:(double)DX Y_Rot:(double)Y_Rot Z_Rot:(double)Z_Rot s:(double)s {
    
    double sfactor = s * 0.000001;
    
    double RadY_Rot = [self toRadians:(Y_Rot / 3600)];
    double RadZ_Rot = [self toRadians:(Z_Rot / 3600)];
    
    return  X + (X * sfactor) - (Y * RadZ_Rot) + (Z * RadY_Rot) + DX;
}

- (double)helmertY_X:(double)X Y:(double)Y Z:(double)Z DY:(double)DY X_Rot:(double)X_Rot Z_Rot:(double)Z_Rot s:(double)s {
    
    double sfactor = s * 0.000001;
    
    double RadX_Rot = [self toRadians:(X_Rot / 3600)];
    double RadZ_Rot = [self toRadians:(Z_Rot / 3600)];
    
    return (X * RadZ_Rot) + Y + (Y * sfactor) - (Z * RadX_Rot) + DY;
}

- (double)helmertZ_X:(double)X Y:(double)Y Z:(double)Z DZ:(double)DZ X_Rot:(double)X_Rot Y_Rot:(double)Y_Rot s:(double)s {
    
    double sfactor = s * 0.000001;
    
    double RadX_Rot = [self toRadians:(X_Rot / 3600)];
    double RadY_Rot = [self toRadians:(Y_Rot / 3600)];
    
    return (-1 * X * RadY_Rot) + (Y * RadX_Rot) + Z + (Z * sfactor) + DZ;
}

- (double)xyzToLat_X:(double)X Y:(double)Y Z:(double)Z a:(double)a b:(double)b {
    
    double RootXYSqr = sqrt(pow(X, 2) + pow(Y, 2));
    double e2 = (pow(a, 2) - pow(b, 2)) / pow(a, 2);
    double φ1 = atan2(Z, (RootXYSqr * (1 - e2)));
    
    double φ = [self iterateXYZtoLat_a:a e2:e2 φ1:φ1 Z:Z RootXYSqr:RootXYSqr];
    
    return [self toDegrees:φ];
}

- (double)iterateXYZtoLat_a:(double)a e2:(double)e2 φ1:(double)φ1 Z:(double)Z RootXYSqr:(double)RootXYSqr {
    
    double V = a / (sqrt(1 - (e2 * pow(sin(φ1), 2))));
    double φ2 = atan2((Z + (e2 * V * (sin(φ1)))), RootXYSqr);
    
    while (abs(φ1 - φ2) > 0.000000001) {
        φ1 = φ2;
        V = a / (sqrt(1 - (e2 * pow(sin(φ1), 2))));
        φ2 = atan2((Z + (e2 * V * (sin(φ1)))) , RootXYSqr);
    }
    
    return φ2;
}

- (double)xyzToLon_X:(double)X Y:(double)Y {
    
    return [self toDegrees:atan2(Y, X)];
}

- (double)marc_bf0:(double)bf0 n:(double)n φ0:(double)φ0 φ:(double)φ {
    return bf0 * (((1 + n + ((5 / 4) * pow(n, 2)) + ((5 / 4) * pow(n, 3))) * (φ - φ0)) - (((3 * n) + (3 * pow(n, 2)) + ((21 / 8) * pow(n, 3))) * (sin(φ - φ0)) * (cos(φ + φ0))) + ((((15 / 8) * pow(n, 2)) + ((15 / 8) * pow(n, 3))) * (sin(2 * (φ - φ0))) * (cos(2 * (φ + φ0)))) - (((35 / 24) * pow(n, 3)) * (sin(3 * (φ - φ0))) * (cos(3 * (φ + φ0)))));
}

- (double)toDegrees:(double) radians {
    return radians / M_PI * 180;
}

- (double)toRadians:(double) degrees {
    return degrees * M_PI / 180;
}

@end
