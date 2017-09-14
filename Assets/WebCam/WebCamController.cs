using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WebCamController : MonoBehaviour {

    int width = 1920;
    int height = 1080;
    int fps = 60;
    Texture2D texture;
    WebCamTexture webcamTexture;
    Color32[] colors = null;


    // Use this for initialization
    void Start () {
        WebCamDevice[] devices = WebCamTexture.devices;
        webcamTexture = new WebCamTexture(devices[0].name, this.width, this.height, this.fps);
        GetComponent<Renderer> ().material.mainTexture = webcamTexture;
        webcamTexture.Play();
    }
}