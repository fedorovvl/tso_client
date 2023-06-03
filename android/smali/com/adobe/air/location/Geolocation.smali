.class public Lcom/adobe/air/location/Geolocation;
.super Ljava/lang/Object;
.source "Geolocation.java"


# instance fields
.field private mGPSListener:Lcom/adobe/air/location/AIRLocationListener;

.field private mLocationManager:Landroid/location/LocationManager;

.field private mNetworkListener:Lcom/adobe/air/location/AIRLocationListener;

.field protected m_EventSourceExists:Z

.field protected m_altitude:D

.field private m_context:Landroid/content/Context;

.field protected m_currentTime:Landroid/text/format/Time;

.field protected m_gpsAltitude:D

.field protected m_gpsHorizontalAaccuracy:F

.field protected m_gpsLatitude:D

.field protected m_gpsLongitude:D

.field protected m_gpsSpeed:F

.field protected m_gpsTimestamp:J

.field protected m_gpsVerticalAccuracy:F

.field protected m_horizontalAaccuracy:F

.field protected m_ignoreLastGPSValue:Z

.field protected m_isGPSProviderEnabled:Z

.field protected m_isNetworkProviderEnabled:Z

.field protected m_latitude:D

.field protected m_longitude:D

.field protected m_networkAltitude:D

.field protected m_networkHorizontalAaccuracy:F

.field protected m_networkLatitude:D

.field protected m_networkLongitude:D

.field protected m_networkSpeed:F

.field protected m_networkTimestamp:J

.field protected m_networkVerticalAccuracy:F

.field protected m_objectPointer:J

.field protected m_speed:F

.field protected m_timestamp:J

.field private m_upateInterval:J

.field protected m_verticalAccuracy:F


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 142
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 145
    :try_start_0
    iput-object p1, p0, Lcom/adobe/air/location/Geolocation;->m_context:Landroid/content/Context;

    .line 147
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/adobe/air/location/Geolocation;->m_EventSourceExists:Z

    .line 149
    new-instance v0, Lcom/adobe/air/location/AIRLocationListener;

    invoke-direct {v0, p0}, Lcom/adobe/air/location/AIRLocationListener;-><init>(Lcom/adobe/air/location/Geolocation;)V

    iput-object v0, p0, Lcom/adobe/air/location/Geolocation;->mGPSListener:Lcom/adobe/air/location/AIRLocationListener;

    .line 150
    new-instance v0, Lcom/adobe/air/location/AIRLocationListener;

    invoke-direct {v0, p0}, Lcom/adobe/air/location/AIRLocationListener;-><init>(Lcom/adobe/air/location/Geolocation;)V

    iput-object v0, p0, Lcom/adobe/air/location/Geolocation;->mNetworkListener:Lcom/adobe/air/location/AIRLocationListener;

    .line 151
    iget-object v0, p0, Lcom/adobe/air/location/Geolocation;->m_context:Landroid/content/Context;

    const-string v1, "location"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/location/LocationManager;

    iput-object v0, p0, Lcom/adobe/air/location/Geolocation;->mLocationManager:Landroid/location/LocationManager;

    .line 153
    iget-object v0, p0, Lcom/adobe/air/location/Geolocation;->mLocationManager:Landroid/location/LocationManager;

    const-string v1, "gps"

    invoke-virtual {v0, v1}, Landroid/location/LocationManager;->isProviderEnabled(Ljava/lang/String;)Z

    move-result v0

    iput-boolean v0, p0, Lcom/adobe/air/location/Geolocation;->m_isGPSProviderEnabled:Z

    .line 154
    iget-object v0, p0, Lcom/adobe/air/location/Geolocation;->mLocationManager:Landroid/location/LocationManager;

    const-string v1, "network"

    invoke-virtual {v0, v1}, Landroid/location/LocationManager;->isProviderEnabled(Ljava/lang/String;)Z

    move-result v0

    iput-boolean v0, p0, Lcom/adobe/air/location/Geolocation;->m_isNetworkProviderEnabled:Z

    .line 158
    new-instance v0, Landroid/text/format/Time;

    invoke-direct {v0}, Landroid/text/format/Time;-><init>()V

    iput-object v0, p0, Lcom/adobe/air/location/Geolocation;->m_currentTime:Landroid/text/format/Time;

    .line 159
    iget-object v0, p0, Lcom/adobe/air/location/Geolocation;->m_currentTime:Landroid/text/format/Time;

    invoke-virtual {v0}, Landroid/text/format/Time;->setToNow()V

    .line 161
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/adobe/air/location/Geolocation;->m_ignoreLastGPSValue:Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 167
    :goto_0
    return-void

    .line 163
    :catch_0
    move-exception v0

    goto :goto_0
.end method


# virtual methods
.method protected addGPSListener()V
    .locals 7

    .prologue
    .line 112
    iget-object v0, p0, Lcom/adobe/air/location/Geolocation;->m_context:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    const-string v1, "android.hardware.location.gps"

    invoke-virtual {v0, v1}, Landroid/content/pm/PackageManager;->hasSystemFeature(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 114
    iget-object v0, p0, Lcom/adobe/air/location/Geolocation;->mLocationManager:Landroid/location/LocationManager;

    const-string v1, "gps"

    invoke-virtual {v0, v1}, Landroid/location/LocationManager;->getLastKnownLocation(Ljava/lang/String;)Landroid/location/Location;

    move-result-object v6

    .line 115
    .local v6, "myLocation":Landroid/location/Location;
    iget-object v0, p0, Lcom/adobe/air/location/Geolocation;->mGPSListener:Lcom/adobe/air/location/AIRLocationListener;

    invoke-virtual {v0, v6}, Lcom/adobe/air/location/AIRLocationListener;->onLocationChanged(Landroid/location/Location;)V

    .line 116
    iget-object v0, p0, Lcom/adobe/air/location/Geolocation;->mLocationManager:Landroid/location/LocationManager;

    const-string v1, "gps"

    iget-wide v2, p0, Lcom/adobe/air/location/Geolocation;->m_upateInterval:J

    const/4 v4, 0x0

    iget-object v5, p0, Lcom/adobe/air/location/Geolocation;->mGPSListener:Lcom/adobe/air/location/AIRLocationListener;

    invoke-virtual/range {v0 .. v5}, Landroid/location/LocationManager;->requestLocationUpdates(Ljava/lang/String;JFLandroid/location/LocationListener;)V

    .line 118
    .end local v6    # "myLocation":Landroid/location/Location;
    :cond_0
    return-void
.end method

.method protected addLocationListeners()V
    .locals 2

    .prologue
    .line 94
    iget-object v0, p0, Lcom/adobe/air/location/Geolocation;->m_context:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    const-string v1, "android.hardware.location"

    invoke-virtual {v0, v1}, Landroid/content/pm/PackageManager;->hasSystemFeature(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 96
    invoke-virtual {p0}, Lcom/adobe/air/location/Geolocation;->addGPSListener()V

    .line 97
    invoke-virtual {p0}, Lcom/adobe/air/location/Geolocation;->addNetworkListener()V

    .line 99
    :cond_0
    return-void
.end method

.method protected addNetworkListener()V
    .locals 6

    .prologue
    .line 130
    iget-object v0, p0, Lcom/adobe/air/location/Geolocation;->m_context:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    const-string v1, "android.hardware.location.network"

    invoke-virtual {v0, v1}, Landroid/content/pm/PackageManager;->hasSystemFeature(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 131
    iget-object v0, p0, Lcom/adobe/air/location/Geolocation;->mLocationManager:Landroid/location/LocationManager;

    const-string v1, "network"

    iget-wide v2, p0, Lcom/adobe/air/location/Geolocation;->m_upateInterval:J

    const/4 v4, 0x0

    iget-object v5, p0, Lcom/adobe/air/location/Geolocation;->mNetworkListener:Lcom/adobe/air/location/AIRLocationListener;

    invoke-virtual/range {v0 .. v5}, Landroid/location/LocationManager;->requestLocationUpdates(Ljava/lang/String;JFLandroid/location/LocationListener;)V

    .line 132
    :cond_0
    return-void
.end method

.method public isGeolocationMuted()Z
    .locals 1

    .prologue
    .line 45
    iget-boolean v0, p0, Lcom/adobe/air/location/Geolocation;->m_isGPSProviderEnabled:Z

    if-nez v0, :cond_0

    iget-boolean v0, p0, Lcom/adobe/air/location/Geolocation;->m_isNetworkProviderEnabled:Z

    if-eqz v0, :cond_1

    .line 48
    :cond_0
    const/4 v0, 0x0

    .line 53
    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x1

    goto :goto_0
.end method

.method protected releaseAllResources()V
    .locals 1

    .prologue
    .line 88
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/adobe/air/location/Geolocation;->m_EventSourceExists:Z

    .line 89
    invoke-virtual {p0}, Lcom/adobe/air/location/Geolocation;->removeLocationListeners()V

    .line 90
    return-void
.end method

.method protected removeGPSListener()V
    .locals 2

    .prologue
    .line 123
    iget-object v0, p0, Lcom/adobe/air/location/Geolocation;->m_context:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    const-string v1, "android.hardware.location.gps"

    invoke-virtual {v0, v1}, Landroid/content/pm/PackageManager;->hasSystemFeature(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 124
    iget-object v0, p0, Lcom/adobe/air/location/Geolocation;->mLocationManager:Landroid/location/LocationManager;

    iget-object v1, p0, Lcom/adobe/air/location/Geolocation;->mGPSListener:Lcom/adobe/air/location/AIRLocationListener;

    invoke-virtual {v0, v1}, Landroid/location/LocationManager;->removeUpdates(Landroid/location/LocationListener;)V

    .line 125
    :cond_0
    return-void
.end method

.method protected removeLocationListeners()V
    .locals 2

    .prologue
    .line 103
    iget-object v0, p0, Lcom/adobe/air/location/Geolocation;->m_context:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    const-string v1, "android.hardware.location"

    invoke-virtual {v0, v1}, Landroid/content/pm/PackageManager;->hasSystemFeature(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 105
    invoke-virtual {p0}, Lcom/adobe/air/location/Geolocation;->removeGPSListener()V

    .line 106
    invoke-virtual {p0}, Lcom/adobe/air/location/Geolocation;->removeNetworkListener()V

    .line 108
    :cond_0
    return-void
.end method

.method protected removeNetworkListener()V
    .locals 2

    .prologue
    .line 137
    iget-object v0, p0, Lcom/adobe/air/location/Geolocation;->m_context:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    const-string v1, "android.hardware.location.network"

    invoke-virtual {v0, v1}, Landroid/content/pm/PackageManager;->hasSystemFeature(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 138
    iget-object v0, p0, Lcom/adobe/air/location/Geolocation;->mLocationManager:Landroid/location/LocationManager;

    iget-object v1, p0, Lcom/adobe/air/location/Geolocation;->mNetworkListener:Lcom/adobe/air/location/AIRLocationListener;

    invoke-virtual {v0, v1}, Landroid/location/LocationManager;->removeUpdates(Landroid/location/LocationListener;)V

    .line 139
    :cond_0
    return-void
.end method

.method public setGeolocationEventSource(J)V
    .locals 1
    .param p1, "obj"    # J

    .prologue
    .line 62
    :try_start_0
    iput-wide p1, p0, Lcom/adobe/air/location/Geolocation;->m_objectPointer:J
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 68
    :goto_0
    return-void

    .line 64
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method protected native setGeolocationStatus(ZJ)V
.end method

.method public setUpdateTimeAndRegister(JJ)V
    .locals 1
    .param p1, "time"    # J
    .param p3, "obj"    # J

    .prologue
    .line 76
    :try_start_0
    iput-wide p3, p0, Lcom/adobe/air/location/Geolocation;->m_objectPointer:J

    .line 77
    iput-wide p1, p0, Lcom/adobe/air/location/Geolocation;->m_upateInterval:J

    .line 78
    invoke-virtual {p0}, Lcom/adobe/air/location/Geolocation;->addLocationListeners()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 84
    :goto_0
    return-void

    .line 80
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method protected native updateGeolocationCache(J)V
.end method
