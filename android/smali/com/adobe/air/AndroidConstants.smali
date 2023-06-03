.class public final Lcom/adobe/air/AndroidConstants;
.super Ljava/lang/Object;
.source "AndroidConstants.java"


# static fields
.field public static final ADOBE:Ljava/lang/String; = "adobe"

.field public static final ADOBE_AIR:Ljava/lang/String; = "Adobe AIR"

.field public static final AIR:Ljava/lang/String; = "AIR"

.field public static final ANDROID_RESOURCE_DEBUG_RAW_INFO:Ljava/lang/String; = "raw.debuginfo"

.field public static final ANDROID_RESOURCE_RAW_INFO:Ljava/lang/String; = "raw.debugger"

.field public static final ANDROID_RESOURCE_RGBA8888:Ljava/lang/String; = "raw.rgba8888"

.field public static DEBUGGER_INFO:Ljava/lang/String; = null

.field public static NETWORK_REQUEST_TIME_OUT:I = 0x0

.field public static final PROFILER_RES_RAW_INFO:Ljava/lang/String; = "raw.profileragent"


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 33
    const/16 v0, 0x3e8

    sput v0, Lcom/adobe/air/AndroidConstants;->NETWORK_REQUEST_TIME_OUT:I

    .line 36
    const-string v0, "debugInfo"

    sput-object v0, Lcom/adobe/air/AndroidConstants;->DEBUGGER_INFO:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 20
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
