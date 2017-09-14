using UnityEngine;
using System.Collections;

public class DotMatrixEffect : MonoBehaviour {

	public bool on = false;

	[Range(1, 200)]
	public int amount = 40;

	[Range(0.01f, 1f)]
	public float size = 0.3f;

	[Range(0.01f, 1f)]
	public float blur = 0.3f;

	public Material material;


	void OnRenderImage(RenderTexture src, RenderTexture dest)
	{
		if(on)
		{
			Graphics.Blit(src, dest, material);
		}
		else
		{
			Graphics.Blit(src, dest);
		}
	}


	void Update()
	{
		if(on)
		{
			material.SetInt("_Amount", amount);
			material.SetFloat("_Size", size);
			material.SetFloat("_Blur", blur);
		}
	}
}