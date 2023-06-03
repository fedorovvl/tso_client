.class public final Lcom/adobe/air/AndroidActivityWrapper$FlashPermission;
.super Ljava/lang/Object;
.source "AndroidActivityWrapper.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/adobe/air/AndroidActivityWrapper;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x11
    name = "FlashPermission"
.end annotation


# static fields
.field public static final CAMERA:I = 0x4

.field public static final CAMERA_ROLL:I = 0x16

.field public static final CAMERA_UI:I = 0x32

.field public static final LOCATION:I = 0x1

.field public static final MICROPHONE:I = 0x2

.field public static final NETWORK:I = 0x128

.field public static final STORAGE:I = 0x8

.field public static final WIFI:I = 0x64


# instance fields
.field final synthetic this$0:Lcom/adobe/air/AndroidActivityWrapper;


# direct methods
.method public constructor <init>(Lcom/adobe/air/AndroidActivityWrapper;)V
    .locals 0
    .param p1, "this$0"    # Lcom/adobe/air/AndroidActivityWrapper;

    .prologue
    .line 160
    iput-object p1, p0, Lcom/adobe/air/AndroidActivityWrapper$FlashPermission;->this$0:Lcom/adobe/air/AndroidActivityWrapper;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
