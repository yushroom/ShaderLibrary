#ifndef _MY_MATRIX_H_
#define _MY_MATRIX_H_

float4x4 MatrixLookAtLH(float3 eye, float3 lookAt, float3 up)
{
	float3 v = normalize(lookAt - eye);
	float3 r = normalize(cross(up, v));
	up = normalize(cross(v, r));

	float x = -dot(eye, r);
	float y = -dot(eye, up);
	float z = -dot(eye, v);

	return float4x4(	float4(r.x, up.x, v.x, 0),
						float4(r.y, up.y, v.y, 0),
						float4(r.z, up.z, v.z, 0),
						float4(x,   y,    z,   1));
}

float4x4 MatrixPerspectiveFovLH(float fov, float aspect, float zn, float zf)
{
	fov = radians(fov);
	return float4x4( 	float4(1.f/tan(fov/2)/aspect, 0, 0, 0),
						float4(0, 1.f/tan(fov/2), 0, 0),
						float4(0, 0, zf / (zf-zn), 1),
						float4(0, 0, zf * zn / (zn-zf), 0) );
}

#endif