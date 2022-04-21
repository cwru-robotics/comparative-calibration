function PIXEL_POINT = project(METRIC_POINT, F, C, D)
	    %Preprojection
	    xp1 = METRIC_POINT(1);
		yp1 = METRIC_POINT(2);
		zp1 = METRIC_POINT(3);
		
		if(zp1 ~= 0)%If the distance to the image plane is zero something is VERY wrong.
			xp_plane = xp1 / zp1;
			yp_plane = yp1 / zp1;
        end
		
		%Distortion.
		r2 = (xp_plane .^ 2.0) + (yp_plane .^ 2.0);
		r4 = r2 * r2;
		r6 = r2 * r2 * r2;
		
		X_radial = xp_plane * D(1) * r2 + xp_plane * D(2) * r4 + xp_plane * D(3) * r6;
		Y_radial = yp_plane * D(1) * r2 + yp_plane * D(2) * r4 + yp_plane * D(3) * r6;
		
		X_tangential = 2.0 * D(4) * xp_plane * yp_plane + D(5) * (r2 + 2.0 * xp_plane * xp_plane);
		Y_tangential = D(4) * (r2 + 2.0 * yp_plane * yp_plane) + 2.0 * D(5) * xp_plane * yp_plane;
		
		xd = xp_plane;% + X_radial + X_tangential;
		yd = yp_plane;% + Y_radial + Y_tangential;
		
		%Project
		PIXEL_POINT = [C(1) + F(1) * xd, C(2) + F(2) * yd];
end