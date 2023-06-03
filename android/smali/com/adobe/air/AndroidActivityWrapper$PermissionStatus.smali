.class public final Lcom/adobe/air/AndroidActivityWrapper$PermissionStatus;
.super Ljava/lang/Object;
.source "AndroidActivityWrapper.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/adobe/air/AndroidActivityWrapper;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x11
    name = "PermissionStatus"
.end annotation


# static fields
.field public static final DENIED:I = 0x2

.field public static final GRANTED:I = 0x1

.field public static final UNKNOWN:I


# instance fields
.field final synthetic this$0:Lcom/adobe/air/AndroidActivityWrapper;


# direct methods
.method public constructor <init>(Lcom/adobe/air/AndroidActivityWrapper;)V
    .locals 0
    .param p1, "this$0"    # Lcom/adobe/air/AndroidActivityWrapper;

    .prologue
    .line 154
    iput-object p1, p0, Lcom/adobe/air/AndroidActivityWrapper$PermissionStatus;->this$0:Lcom/adobe/air/AndroidActivityWrapper;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
